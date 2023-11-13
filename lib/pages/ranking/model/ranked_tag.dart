import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_trend/pages/ranking/model/tag_history.dart';

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
      List<dynamic>? followerCountHistory,
      List<dynamic>? itemsCountHistory}) = _RankedTag;
  factory RankedTag.fromDocument(DocumentSnapshot doc) {
    return RankedTag(
      id: doc['id'].toString(),
      date: doc['date'] as Timestamp,
      followersCount: doc['followers_count'] as int,
      itemsCount: doc['items_count'] as int,
      followersCountChange: doc['followers_count_change'] as int,
      itemsCountChange: doc['items_count_change'] as int,
      documentSnapshot: doc,
      iconUrl: doc['icon_url'] as String?,
      followerCountHistory: doc['followers_count_history'] as List<dynamic>?,
      itemsCountHistory: doc['items_count_history'] as List<dynamic>?,
    );
  }
}
