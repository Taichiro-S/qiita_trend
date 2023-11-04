// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TagInfo {
  String get id => throw _privateConstructorUsedError;
  String get followersCount => throw _privateConstructorUsedError;
  String get itemsCount => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TagInfoCopyWith<TagInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagInfoCopyWith<$Res> {
  factory $TagInfoCopyWith(TagInfo value, $Res Function(TagInfo) then) =
      _$TagInfoCopyWithImpl<$Res, TagInfo>;
  @useResult
  $Res call(
      {String id, String followersCount, String itemsCount, String? iconUrl});
}

/// @nodoc
class _$TagInfoCopyWithImpl<$Res, $Val extends TagInfo>
    implements $TagInfoCopyWith<$Res> {
  _$TagInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? followersCount = null,
    Object? itemsCount = null,
    Object? iconUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as String,
      itemsCount: null == itemsCount
          ? _value.itemsCount
          : itemsCount // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagInfoImplCopyWith<$Res> implements $TagInfoCopyWith<$Res> {
  factory _$$TagInfoImplCopyWith(
          _$TagInfoImpl value, $Res Function(_$TagInfoImpl) then) =
      __$$TagInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String followersCount, String itemsCount, String? iconUrl});
}

/// @nodoc
class __$$TagInfoImplCopyWithImpl<$Res>
    extends _$TagInfoCopyWithImpl<$Res, _$TagInfoImpl>
    implements _$$TagInfoImplCopyWith<$Res> {
  __$$TagInfoImplCopyWithImpl(
      _$TagInfoImpl _value, $Res Function(_$TagInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? followersCount = null,
    Object? itemsCount = null,
    Object? iconUrl = freezed,
  }) {
    return _then(_$TagInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as String,
      itemsCount: null == itemsCount
          ? _value.itemsCount
          : itemsCount // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TagInfoImpl with DiagnosticableTreeMixin implements _TagInfo {
  const _$TagInfoImpl(
      {required this.id,
      required this.followersCount,
      required this.itemsCount,
      this.iconUrl});

  @override
  final String id;
  @override
  final String followersCount;
  @override
  final String itemsCount;
  @override
  final String? iconUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TagInfo(id: $id, followersCount: $followersCount, itemsCount: $itemsCount, iconUrl: $iconUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TagInfo'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('followersCount', followersCount))
      ..add(DiagnosticsProperty('itemsCount', itemsCount))
      ..add(DiagnosticsProperty('iconUrl', iconUrl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.itemsCount, itemsCount) ||
                other.itemsCount == itemsCount) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, followersCount, itemsCount, iconUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagInfoImplCopyWith<_$TagInfoImpl> get copyWith =>
      __$$TagInfoImplCopyWithImpl<_$TagInfoImpl>(this, _$identity);
}

abstract class _TagInfo implements TagInfo {
  const factory _TagInfo(
      {required final String id,
      required final String followersCount,
      required final String itemsCount,
      final String? iconUrl}) = _$TagInfoImpl;

  @override
  String get id;
  @override
  String get followersCount;
  @override
  String get itemsCount;
  @override
  String? get iconUrl;
  @override
  @JsonKey(ignore: true)
  _$$TagInfoImplCopyWith<_$TagInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
