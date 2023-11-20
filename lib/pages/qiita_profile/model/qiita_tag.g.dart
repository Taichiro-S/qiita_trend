// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qiita_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QiitaTagImpl _$$QiitaTagImplFromJson(Map<String, dynamic> json) =>
    _$QiitaTagImpl(
      followersCount: json['followers_count'] as int?,
      iconUrl: json['icon_url'] as String?,
      id: json['id'] as String,
      itemsCount: json['items_count'] as int?,
    );

Map<String, dynamic> _$$QiitaTagImplToJson(_$QiitaTagImpl instance) =>
    <String, dynamic>{
      'followers_count': instance.followersCount,
      'icon_url': instance.iconUrl,
      'id': instance.id,
      'items_count': instance.itemsCount,
    };
