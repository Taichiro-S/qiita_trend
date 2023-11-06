import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qiita_trend/constant/default_values.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/pages/ranking/model/tag_info.dart';

part 'tags_repository.g.dart';

class TagsRepository {
  Future<List<TagInfo>> getAllTags() async {
    try {
      final snap = await FirebaseFirestore.instance.collection('tags').get();
      return snap.docs.map((e) => TagInfo.fromDocument(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TagInfo>> getSortedTags({
    required TagsField fieldOrderBy,
    int limit = DEFAULT_LOAD_TAGS,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query query = FirebaseFirestore.instance
          .collection('tags')
          .orderBy(fieldOrderBy.name, descending: true)
          .limit(limit);
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      final QuerySnapshot snap = await query.get();
      return snap.docs.map((doc) => TagInfo.fromDocument(doc)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}

@riverpod
TagsRepository tagsRepository(TagsRepositoryRef ref) {
  return TagsRepository();
}
