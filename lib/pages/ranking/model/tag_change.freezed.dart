// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_change.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TagChange {
  Timestamp get createdAt => throw _privateConstructorUsedError;
  String get followersCount => throw _privateConstructorUsedError;
  String get itemsCount => throw _privateConstructorUsedError;
  String get followersChange => throw _privateConstructorUsedError;
  String get itemsChange => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TagChangeCopyWith<TagChange> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagChangeCopyWith<$Res> {
  factory $TagChangeCopyWith(TagChange value, $Res Function(TagChange) then) =
      _$TagChangeCopyWithImpl<$Res, TagChange>;
  @useResult
  $Res call(
      {Timestamp createdAt,
      String followersCount,
      String itemsCount,
      String followersChange,
      String itemsChange});
}

/// @nodoc
class _$TagChangeCopyWithImpl<$Res, $Val extends TagChange>
    implements $TagChangeCopyWith<$Res> {
  _$TagChangeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? followersCount = null,
    Object? itemsCount = null,
    Object? followersChange = null,
    Object? itemsChange = null,
  }) {
    return _then(_value.copyWith(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as String,
      itemsCount: null == itemsCount
          ? _value.itemsCount
          : itemsCount // ignore: cast_nullable_to_non_nullable
              as String,
      followersChange: null == followersChange
          ? _value.followersChange
          : followersChange // ignore: cast_nullable_to_non_nullable
              as String,
      itemsChange: null == itemsChange
          ? _value.itemsChange
          : itemsChange // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagChangeImplCopyWith<$Res>
    implements $TagChangeCopyWith<$Res> {
  factory _$$TagChangeImplCopyWith(
          _$TagChangeImpl value, $Res Function(_$TagChangeImpl) then) =
      __$$TagChangeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Timestamp createdAt,
      String followersCount,
      String itemsCount,
      String followersChange,
      String itemsChange});
}

/// @nodoc
class __$$TagChangeImplCopyWithImpl<$Res>
    extends _$TagChangeCopyWithImpl<$Res, _$TagChangeImpl>
    implements _$$TagChangeImplCopyWith<$Res> {
  __$$TagChangeImplCopyWithImpl(
      _$TagChangeImpl _value, $Res Function(_$TagChangeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? followersCount = null,
    Object? itemsCount = null,
    Object? followersChange = null,
    Object? itemsChange = null,
  }) {
    return _then(_$TagChangeImpl(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as String,
      itemsCount: null == itemsCount
          ? _value.itemsCount
          : itemsCount // ignore: cast_nullable_to_non_nullable
              as String,
      followersChange: null == followersChange
          ? _value.followersChange
          : followersChange // ignore: cast_nullable_to_non_nullable
              as String,
      itemsChange: null == itemsChange
          ? _value.itemsChange
          : itemsChange // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TagChangeImpl with DiagnosticableTreeMixin implements _TagChange {
  const _$TagChangeImpl(
      {required this.createdAt,
      required this.followersCount,
      required this.itemsCount,
      required this.followersChange,
      required this.itemsChange});

  @override
  final Timestamp createdAt;
  @override
  final String followersCount;
  @override
  final String itemsCount;
  @override
  final String followersChange;
  @override
  final String itemsChange;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TagChange(createdAt: $createdAt, followersCount: $followersCount, itemsCount: $itemsCount, followersChange: $followersChange, itemsChange: $itemsChange)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TagChange'))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('followersCount', followersCount))
      ..add(DiagnosticsProperty('itemsCount', itemsCount))
      ..add(DiagnosticsProperty('followersChange', followersChange))
      ..add(DiagnosticsProperty('itemsChange', itemsChange));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagChangeImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.itemsCount, itemsCount) ||
                other.itemsCount == itemsCount) &&
            (identical(other.followersChange, followersChange) ||
                other.followersChange == followersChange) &&
            (identical(other.itemsChange, itemsChange) ||
                other.itemsChange == itemsChange));
  }

  @override
  int get hashCode => Object.hash(runtimeType, createdAt, followersCount,
      itemsCount, followersChange, itemsChange);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagChangeImplCopyWith<_$TagChangeImpl> get copyWith =>
      __$$TagChangeImplCopyWithImpl<_$TagChangeImpl>(this, _$identity);
}

abstract class _TagChange implements TagChange {
  const factory _TagChange(
      {required final Timestamp createdAt,
      required final String followersCount,
      required final String itemsCount,
      required final String followersChange,
      required final String itemsChange}) = _$TagChangeImpl;

  @override
  Timestamp get createdAt;
  @override
  String get followersCount;
  @override
  String get itemsCount;
  @override
  String get followersChange;
  @override
  String get itemsChange;
  @override
  @JsonKey(ignore: true)
  _$$TagChangeImplCopyWith<_$TagChangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
