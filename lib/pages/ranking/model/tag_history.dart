import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'tag_history.freezed.dart';

@freezed
class TagHistory with _$TagHistory {
  const factory TagHistory({required Timestamp date, required int change}) =
      _TagHistory;
}
