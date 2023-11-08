import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_trend/pages/ranking/model/tag_info.dart';
part 'tags_state.freezed.dart';

@freezed
class TagsState with _$TagsState {
  const factory TagsState({
    required AsyncValue<List<TagInfo>> tags,
    required DocumentSnapshot? lastDoc,
    required bool isLoadingMore,
  }) = _TagsState;
}
