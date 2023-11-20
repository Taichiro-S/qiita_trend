import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qiita_trend/constant/default_value.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/ranking/model/ranked_tag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranked_tags_repository.g.dart';

class RankedTagsRepository {
  Future<List<RankedTag>> fetchRankedTags({
    required Collection timePeriod,
    required RankedTagsSortOrder sortOrder,
    int limit = DEFAULT_LOAD_TAGS,
    DocumentSnapshot? startAfter,
    String? searchWord,
  }) async {
    try {
      String searchWordLower = '';
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
      Query query;
      if (searchWord != null && searchWord.isNotEmpty) {
        searchWordLower = searchWord.toLowerCase();
        query = rankedTagsDocRef
            .collection('tags')
            .where('name', isGreaterThanOrEqualTo: searchWordLower)
            .where('name', isLessThan: '$searchWordLower\uf8ff')
            .orderBy('name')
            .limit(limit);
      } else {
        query = rankedTagsDocRef
            .collection('tags')
            .where(sortOrder.name,
                isGreaterThanOrEqualTo: timePeriod.name ==
                            Collection.weeklyRanking.name &&
                        sortOrder == RankedTagsSortOrder.itemsCountChange
                    ? DEFAULT_WEEKLY_ITEMS_CHANGE_CUTOFF
                    : timePeriod.name == Collection.weeklyRanking.name &&
                            sortOrder == RankedTagsSortOrder.itemsCountChange
                        ? DEFAULT_MONTHLY_ITEMS_CHANGE_CUTOFF
                        : timePeriod.name == Collection.weeklyRanking.name &&
                                sortOrder ==
                                    RankedTagsSortOrder.follwersCountChange
                            ? DEFAULT_WEEKLY_FOLLOWERS_CHANGE_CUTOFF
                            : DEFAULT_MONTHLY_FOLLOWERS_CHANGE_CUTOFF)
            .orderBy(sortOrder.name, descending: true)
            .limit(limit);
      }
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
