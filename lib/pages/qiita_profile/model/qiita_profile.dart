import 'package:freezed_annotation/freezed_annotation.dart';

part 'qiita_profile.freezed.dart';
part 'qiita_profile.g.dart';

@freezed
class QiitaProfile with _$QiitaProfile {
  const factory QiitaProfile({
    required String? description,
    required String? facebookId,
    required int? followeesCount,
    required int? followersCount,
    required String? githubLoginName,
    required String? id,
    required int? itemsCount,
    required String? linkedinId,
    required String? location,
    required String? name,
    required String? organization,
    required int? permanentId,
    required String? profileImageUrl,
    required bool? teamOnly,
    required String? twitterScreenName,
    required String? websiteUrl,
  }) = _QiitaProfile;

  factory QiitaProfile.fromJson(Map<String, dynamic> json) =>
      _$QiitaProfileFromJson(json);
}
