import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:qiita_trend/constant/default_value.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/ranking/model/ranked_tag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranked_tags_repository.g.dart';

class RankedTagsRepository {
  Future<List<RankedTag>> getRankedTags({
    required Collection timePeriod,
    required RankedTagsSortOrder sortOrder,
    int limit = DEFAULT_LOAD_TAGS,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      final QuerySnapshot rankedTagsSnapshot = await FirebaseFirestore.instance
          .collection(timePeriod.name)
          .orderBy('date', descending: true)
          .limit(1)
          .get();
      if (rankedTagsSnapshot.docs.isEmpty) {
        throw Exception('rankings is empty');
      }
      final DocumentReference rankedTagsDocRef =
          rankedTagsSnapshot.docs.first.reference;
      Query query = rankedTagsDocRef
          .collection('tags')
          .orderBy(sortOrder.name, descending: true)
          .limit(limit);
      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }
      final QuerySnapshot snap = await query.get();
      return snap.docs.map((doc) => RankedTag.fromDocument(doc)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}

@riverpod
RankedTagsRepository rankedTagsRepository(RankedTagsRepositoryRef ref) {
  return RankedTagsRepository();
}
