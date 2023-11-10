// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserSettings {
  String get fieldOrderBy => throw _privateConstructorUsedError;
  int get historyDays => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
          UserSettings value, $Res Function(UserSettings) then) =
      _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call({String fieldOrderBy, int historyDays});
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldOrderBy = null,
    Object? historyDays = null,
  }) {
    return _then(_value.copyWith(
      fieldOrderBy: null == fieldOrderBy
          ? _value.fieldOrderBy
          : fieldOrderBy // ignore: cast_nullable_to_non_nullable
              as String,
      historyDays: null == historyDays
          ? _value.historyDays
          : historyDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
          _$UserSettingsImpl value, $Res Function(_$UserSettingsImpl) then) =
      __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String fieldOrderBy, int historyDays});
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
      _$UserSettingsImpl _value, $Res Function(_$UserSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldOrderBy = null,
    Object? historyDays = null,
  }) {
    return _then(_$UserSettingsImpl(
      fieldOrderBy: null == fieldOrderBy
          ? _value.fieldOrderBy
          : fieldOrderBy // ignore: cast_nullable_to_non_nullable
              as String,
      historyDays: null == historyDays
          ? _value.historyDays
          : historyDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl(
      {required this.fieldOrderBy, required this.historyDays});

  @override
  final String fieldOrderBy;
  @override
  final int historyDays;

  @override
  String toString() {
    return 'UserSettings(fieldOrderBy: $fieldOrderBy, historyDays: $historyDays)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.fieldOrderBy, fieldOrderBy) ||
                other.fieldOrderBy == fieldOrderBy) &&
            (identical(other.historyDays, historyDays) ||
                other.historyDays == historyDays));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fieldOrderBy, historyDays);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings(
      {required final String fieldOrderBy,
      required final int historyDays}) = _$UserSettingsImpl;

  @override
  String get fieldOrderBy;
  @override
  int get historyDays;
  @override
  @JsonKey(ignore: true)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
