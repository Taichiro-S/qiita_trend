// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'qiita_tag.freezed.dart';
part 'qiita_tag.g.dart';

@freezed
class QiitaTag with _$QiitaTag {
  const factory QiitaTag({
    @JsonKey(name: 'followers_count') required int? followersCount,
    @JsonKey(name: 'icon_url') required String? iconUrl,
    required String id,
    @JsonKey(name: 'items_count') required int? itemsCount,
  }) = _QiitaTag;

  factory QiitaTag.fromJson(Map<String, dynamic> json) =>
      _$QiitaTagFromJson(json);
}
