import 'package:qiita_trend/pages/qiita_profile/api/qiita_following_tags_api.dart';
import 'package:qiita_trend/pages/qiita_profile/model/qiita_following_tags_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qiita_following_tags_provider.g.dart';

@riverpod
class QiitaFollowingTags extends _$QiitaFollowingTags {
  @override
  QiitaFollowingTagsState build() {
    return const QiitaFollowingTagsState(
      followingTags: AsyncValue.data([]),
    );
  }

  Future<void> getFollowingTags({required String userId}) async {
    final api = QiitaFollowingTagsApi();
    final followingTags = await api.fetchFollowingTags(userId: userId);
    state = state.copyWith(
      followingTags: AsyncValue.data(followingTags),
    );
  }

  Future<void> followTag(
      {required String userId, required String tagId}) async {
    final api = QiitaFollowingTagsApi();
    final updatedFollowingTags =
        await api.followTag(userId: userId, tagId: tagId);
    state = state.copyWith(
      followingTags: AsyncValue.data(updatedFollowingTags),
    );
  }

  Future<void> unfollowTag(
      {required String userId, required String tagId}) async {
    final api = QiitaFollowingTagsApi();
    final updatedFollowingTags =
        await api.unfollowTag(userId: userId, tagId: tagId);
    state = state.copyWith(
      followingTags: AsyncValue.data(updatedFollowingTags),
    );
  }
}
