import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/pages/ranking/model/tag_info.dart';

part 'tags_repository.g.dart';

class TagsRepository {
  Future<List<TagInfo>> getAllTags() async {
    try {
      final snap = await FirebaseFirestore.instance.collection('tags').get();
      debugPrint('snap.docs: ${snap.docs.length}');
      final allTags = snap.docs.map((e) => TagInfo.fromDocument(e)).toList();
      return allTags..sort((a, b) => b.itemsCount.compareTo(a.itemsCount));
    } catch (e) {
      throw Exception(e);
    }
  }
}

@riverpod
TagsRepository tagsRepository(TagsRepositoryRef ref) {
  return TagsRepository();
}
