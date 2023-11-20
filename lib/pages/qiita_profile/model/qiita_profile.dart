// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'qiita_profile.freezed.dart';
part 'qiita_profile.g.dart';

@freezed
class QiitaProfile with _$QiitaProfile {
  const factory QiitaProfile({
    required String? description,
    @JsonKey(name: 'facebook_id') required String? facebookId,
    @JsonKey(name: 'followees_count') required int? followeesCount,
    @JsonKey(name: 'followers_count') required int? followersCount,
    @JsonKey(name: 'github_login_name') required String? githubLoginName,
    required String id,
    @JsonKey(name: 'items_count') required int? itemsCount,
    @JsonKey(name: 'linkedin_id') required String? linkedinId,
    required String? location,
    required String? name,
    required String? organization,
    @JsonKey(name: 'permanent_id') required int? permanentId,
    @JsonKey(name: 'profile_image_url') required String? profileImageUrl,
    required bool? teamOnly,
    @JsonKey(name: 'twitter_screen_name') required String? twitterScreenName,
    @JsonKey(name: 'website_url') required String? websiteUrl,
  }) = _QiitaProfile;

  factory QiitaProfile.fromJson(Map<String, dynamic> json) =>
      _$QiitaProfileFromJson(json);
}
