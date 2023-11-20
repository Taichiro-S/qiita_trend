// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qiita_tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QiitaTag _$QiitaTagFromJson(Map<String, dynamic> json) {
  return _QiitaTag.fromJson(json);
}

/// @nodoc
mixin _$QiitaTag {
  @JsonKey(name: 'followers_count')
  int? get followersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'icon_url')
  String? get iconUrl => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'items_count')
  int? get itemsCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QiitaTagCopyWith<QiitaTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QiitaTagCopyWith<$Res> {
  factory $QiitaTagCopyWith(QiitaTag value, $Res Function(QiitaTag) then) =
      _$QiitaTagCopyWithImpl<$Res, QiitaTag>;
  @useResult
  $Res call(
      {@JsonKey(name: 'followers_count') int? followersCount,
      @JsonKey(name: 'icon_url') String? iconUrl,
      String id,
      @JsonKey(name: 'items_count') int? itemsCount});
}

/// @nodoc
class _$QiitaTagCopyWithImpl<$Res, $Val extends QiitaTag>
    implements $QiitaTagCopyWith<$Res> {
  _$QiitaTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followersCount = freezed,
    Object? iconUrl = freezed,
    Object? id = null,
    Object? itemsCount = freezed,
  }) {
    return _then(_value.copyWith(
      followersCount: freezed == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      itemsCount: freezed == itemsCount
          ? _value.itemsCount
          : itemsCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QiitaTagImplCopyWith<$Res>
    implements $QiitaTagCopyWith<$Res> {
  factory _$$QiitaTagImplCopyWith(
          _$QiitaTagImpl value, $Res Function(_$QiitaTagImpl) then) =
      __$$QiitaTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'followers_count') int? followersCount,
      @JsonKey(name: 'icon_url') String? iconUrl,
      String id,
      @JsonKey(name: 'items_count') int? itemsCount});
}

/// @nodoc
class __$$QiitaTagImplCopyWithImpl<$Res>
    extends _$QiitaTagCopyWithImpl<$Res, _$QiitaTagImpl>
    implements _$$QiitaTagImplCopyWith<$Res> {
  __$$QiitaTagImplCopyWithImpl(
      _$QiitaTagImpl _value, $Res Function(_$QiitaTagImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followersCount = freezed,
    Object? iconUrl = freezed,
    Object? id = null,
    Object? itemsCount = freezed,
  }) {
    return _then(_$QiitaTagImpl(
      followersCount: freezed == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      itemsCount: freezed == itemsCount
          ? _value.itemsCount
          : itemsCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QiitaTagImpl implements _QiitaTag {
  const _$QiitaTagImpl(
      {@JsonKey(name: 'followers_count') required this.followersCount,
      @JsonKey(name: 'icon_url') required this.iconUrl,
      required this.id,
      @JsonKey(name: 'items_count') required this.itemsCount});

  factory _$QiitaTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$QiitaTagImplFromJson(json);

  @override
  @JsonKey(name: 'followers_count')
  final int? followersCount;
  @override
  @JsonKey(name: 'icon_url')
  final String? iconUrl;
  @override
  final String id;
  @override
  @JsonKey(name: 'items_count')
  final int? itemsCount;

  @override
  String toString() {
    return 'QiitaTag(followersCount: $followersCount, iconUrl: $iconUrl, id: $id, itemsCount: $itemsCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QiitaTagImpl &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.itemsCount, itemsCount) ||
                other.itemsCount == itemsCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, followersCount, iconUrl, id, itemsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QiitaTagImplCopyWith<_$QiitaTagImpl> get copyWith =>
      __$$QiitaTagImplCopyWithImpl<_$QiitaTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QiitaTagImplToJson(
      this,
    );
  }
}

abstract class _QiitaTag implements QiitaTag {
  const factory _QiitaTag(
          {@JsonKey(name: 'followers_count') required final int? followersCount,
          @JsonKey(name: 'icon_url') required final String? iconUrl,
          required final String id,
          @JsonKey(name: 'items_count') required final int? itemsCount}) =
      _$QiitaTagImpl;

  factory _QiitaTag.fromJson(Map<String, dynamic> json) =
      _$QiitaTagImpl.fromJson;

  @override
  @JsonKey(name: 'followers_count')
  int? get followersCount;
  @override
  @JsonKey(name: 'icon_url')
  String? get iconUrl;
  @override
  String get id;
  @override
  @JsonKey(name: 'items_count')
  int? get itemsCount;
  @override
  @JsonKey(ignore: true)
  _$$QiitaTagImplCopyWith<_$QiitaTagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
