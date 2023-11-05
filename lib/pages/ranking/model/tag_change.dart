import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'tag_change.freezed.dart';

@freezed
class TagChange with _$TagChange {
  const factory TagChange({
    required Timestamp createdAt,
    required String followersCount,
    required String itemsCount,
    required String followersChange,
    required String itemsChange,
  }) = _TagChange;

  factory TagChange.fromDocument(String id, DocumentSnapshot doc) {
    return TagChange(
      createdAt: doc['date'],
      followersCount: doc['followers_count'].toString(),
      itemsCount: doc['items_count'].toString(),
      followersChange: doc['followers_change'].toString(),
      itemsChange: doc['items_change'].toString(),
    );
  }
}
