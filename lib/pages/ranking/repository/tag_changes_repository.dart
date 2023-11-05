import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/pages/ranking/model/tag_change.dart';
import '/constant/default_values.dart';
part 'tag_changes_repository.g.dart';

class TagChangesRepository {
  Future<List<TagChange>> getTagChanges(String id) async {
    try {
      final today = Timestamp.now();
      final tagRef = FirebaseFirestore.instance.collection('tags');
      final tagChangeRef = tagRef
          .doc(id)
          .collection('history')
          .where('date', isLessThan: today)
          .orderBy('date', descending: true)
          .limit(TAG_CHANGES_DAYS);
      final snap = await tagChangeRef.get();
      return snap.docs.map((e) => TagChange.fromDocument(id, e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}

@riverpod
TagChangesRepository tagChangesRepository(TagChangesRepositoryRef ref) {
  return TagChangesRepository();
}
