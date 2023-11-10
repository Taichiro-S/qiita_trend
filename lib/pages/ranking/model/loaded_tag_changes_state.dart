import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_trend/pages/ranking/model/tag_change.dart';
part 'loaded_tag_changes_state.freezed.dart';

@freezed
class LoadedTagChangesState with _$LoadedTagChangesState {
  const factory LoadedTagChangesState({
    required AsyncValue<List<TagChange>> tagChanges,
  }) = _LoadedTagChangesState;
}
