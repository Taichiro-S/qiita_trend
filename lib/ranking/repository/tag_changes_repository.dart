import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/ranking/model/tag_change.dart';

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
          .limit(30);
      final snap = await tagChangeRef.get();
      debugPrint('snap.docs: ${snap.docs[0].data()}');
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
