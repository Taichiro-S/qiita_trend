import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_trend/pages/ranking/model/tag_history_state.dart';

part 'ranked_tag.freezed.dart';

@freezed
class RankedTag with _$RankedTag {
  const factory RankedTag(
      {required String id,
      required Timestamp date,
      required int followersCount,
      required int itemsCount,
      required int followersCountChange,
      required int itemsCountChange,
      required DocumentSnapshot documentSnapshot,
      String? iconUrl,
      List<TagHistoryState>? followersCountHistory,
      List<TagHistoryState>? itemsCountHistory}) = _RankedTag;

  factory RankedTag.fromDocument(DocumentSnapshot doc) {
    List<TagHistoryState> followersCountHistory = [];
    List<TagHistoryState> itemsCountHistory = [];
    (doc['followers_count_history'] as Map<String, dynamic>)
        .forEach((key, value) {
      DateTime dateTime = DateTime.parse(key);
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      int change = value as int;
      followersCountHistory
          .add(TagHistoryState(date: timestamp, change: change));
    });
    (doc['items_count_history'] as Map<String, dynamic>).forEach((key, value) {
      DateTime dateTime = DateTime.parse(key);
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      int change = value as int;
      itemsCountHistory.add(TagHistoryState(date: timestamp, change: change));
    });
    itemsCountHistory.sort((a, b) => a.date.compareTo(b.date));
    followersCountHistory.sort((a, b) => a.date.compareTo(b.date));
    return RankedTag(
      id: doc['id'].toString(),
      date: doc['date'] as Timestamp,
      followersCount: doc['followers_count'] as int,
      itemsCount: doc['items_count'] as int,
      followersCountChange: doc['followers_count_change'] as int,
      itemsCountChange: doc['items_count_change'] as int,
      documentSnapshot: doc,
      iconUrl: doc['icon_url'] as String?,
      followersCountHistory: followersCountHistory,
      itemsCountHistory: itemsCountHistory,
    );
  }
}
