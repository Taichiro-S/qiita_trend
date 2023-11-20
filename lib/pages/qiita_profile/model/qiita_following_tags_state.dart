import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_trend/pages/qiita_profile/model/qiita_tag.dart';

part 'qiita_following_tags_state.freezed.dart';

@freezed
class QiitaFollowingTagsState with _$QiitaFollowingTagsState {
  const factory QiitaFollowingTagsState({
    required AsyncValue<List<QiitaTag>> followingTags,
  }) = _QiitaFollowingTagsState;
}
