import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_trend/pages/ranking/model/tag_info.dart';
part 'loaded_tags_state.freezed.dart';

@freezed
class LoadedTagsState with _$LoadedTagsState {
  const factory LoadedTagsState({
    required AsyncValue<List<TagInfo>> tags,
    required DocumentSnapshot? lastDoc,
    required bool isLoadingMore,
  }) = _LoadedTagsState;
}
