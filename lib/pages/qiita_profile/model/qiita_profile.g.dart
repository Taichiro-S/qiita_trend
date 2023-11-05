// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qiita_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QiitaProfileImpl _$$QiitaProfileImplFromJson(Map<String, dynamic> json) =>
    _$QiitaProfileImpl(
      description: json['description'] as String?,
      facebookId: json['facebookId'] as String?,
      followeesCount: json['followeesCount'] as int?,
      followersCount: json['followersCount'] as int?,
      githubLoginName: json['githubLoginName'] as String?,
      id: json['id'] as String?,
      itemsCount: json['itemsCount'] as int?,
      linkedinId: json['linkedinId'] as String?,
      location: json['location'] as String?,
      name: json['name'] as String?,
      organization: json['organization'] as String?,
      permanentId: json['permanentId'] as int?,
      profileImageUrl: json['profileImageUrl'] as String?,
      teamOnly: json['teamOnly'] as bool?,
      twitterScreenName: json['twitterScreenName'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
    );

Map<String, dynamic> _$$QiitaProfileImplToJson(_$QiitaProfileImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'facebookId': instance.facebookId,
      'followeesCount': instance.followeesCount,
      'followersCount': instance.followersCount,
      'githubLoginName': instance.githubLoginName,
      'id': instance.id,
      'itemsCount': instance.itemsCount,
      'linkedinId': instance.linkedinId,
      'location': instance.location,
      'name': instance.name,
      'organization': instance.organization,
      'permanentId': instance.permanentId,
      'profileImageUrl': instance.profileImageUrl,
      'teamOnly': instance.teamOnly,
      'twitterScreenName': instance.twitterScreenName,
      'websiteUrl': instance.websiteUrl,
    };
