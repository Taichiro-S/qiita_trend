import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'tag_info.freezed.dart';

@freezed
class TagInfo with _$TagInfo {
  const factory TagInfo({
    required String id,
    required String followersCount,
    required String itemsCount,
    String? iconUrl,
  }) = _TagInfo;

  factory TagInfo.fromDocument(DocumentSnapshot doc) {
    return TagInfo(
      id: doc['id'],
      followersCount: doc['followers_count'].toString(),
      itemsCount: doc['items_count'].toString(),
      iconUrl: doc['icon_url'],
    );
  }
}
