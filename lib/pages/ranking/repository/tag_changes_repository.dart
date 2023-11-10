import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qiita_trend/constant/default_values.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/pages/ranking/model/tag_change.dart';
part 'tag_changes_repository.g.dart';

class TagChangesRepository {
  Future<List<TagChange>> getTagChanges(String id, int limit) async {
    try {
      final today = Timestamp.now();
      final tagRef = FirebaseFirestore.instance.collection('tags');
      final tagChangeRef = tagRef
          .doc(id)
          .collection('history')
          .where('date', isLessThan: today)
          .orderBy('date', descending: true)
          .limit(20);
      final snap = await tagChangeRef.get();
      final result =
          snap.docs.map((e) => TagChange.fromDocument(id, e)).toList();
      // print(result);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TagChange>> getSortedTagChanges({
    required TagsField fieldOrderBy,
    required String id,
    int limit = DEFAULT_TAG_HISTORY_DAYS * 4,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      final today = Timestamp.now();
      final tagRef = FirebaseFirestore.instance.collection('tags');
      final tagChangeRef = tagRef
          .doc(id)
          .collection('history')
          .where('date', isLessThan: today)
          .orderBy('date', descending: true)
          .limit(20);
      final snap = await tagChangeRef.get();
      final result =
          snap.docs.map((e) => TagChange.fromDocument(id, e)).toList();
      // print(result);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}

@riverpod
TagChangesRepository tagChangesRepository(TagChangesRepositoryRef ref) {
  return TagChangesRepository();
}
