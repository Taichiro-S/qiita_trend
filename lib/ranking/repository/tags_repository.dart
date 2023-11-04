import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/ranking/model/tag_info.dart';

part 'tags_repository.g.dart';

class TagsRepository {
  Future<List<TagInfo>> getAllTopics() async {
    try {
      final snap = await FirebaseFirestore.instance.collection('tags').get();
      debugPrint('snap.docs: ${snap.docs.length}');
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
