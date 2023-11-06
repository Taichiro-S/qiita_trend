import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<TagInfo>> getSortedTags(
      {required TagsField field, required int limit}) async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection('tags')
          .orderBy(field, descending: true)
          .limit(limit)
          .get();
      return snap.docs.map((e) => TagInfo.fromDocument(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}

@riverpod
TagsRepository tagsRepository(TagsRepositoryRef ref) {
  return TagsRepository();
}
