// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qiita_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QiitaProfileState {
  AsyncValue<QiitaProfile> get qiitaProfile =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QiitaProfileStateCopyWith<QiitaProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QiitaProfileStateCopyWith<$Res> {
  factory $QiitaProfileStateCopyWith(
          QiitaProfileState value, $Res Function(QiitaProfileState) then) =
      _$QiitaProfileStateCopyWithImpl<$Res, QiitaProfileState>;
  @useResult
  $Res call({AsyncValue<QiitaProfile> qiitaProfile});
}

/// @nodoc
class _$QiitaProfileStateCopyWithImpl<$Res, $Val extends QiitaProfileState>
    implements $QiitaProfileStateCopyWith<$Res> {
  _$QiitaProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? qiitaProfile = null,
  }) {
    return _then(_value.copyWith(
      qiitaProfile: null == qiitaProfile
          ? _value.qiitaProfile
          : qiitaProfile // ignore: cast_nullable_to_non_nullable
              as AsyncValue<QiitaProfile>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QiitaProfileStateImplCopyWith<$Res>
    implements $QiitaProfileStateCopyWith<$Res> {
  factory _$$QiitaProfileStateImplCopyWith(_$QiitaProfileStateImpl value,
          $Res Function(_$QiitaProfileStateImpl) then) =
      __$$QiitaProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<QiitaProfile> qiitaProfile});
}

/// @nodoc
class __$$QiitaProfileStateImplCopyWithImpl<$Res>
    extends _$QiitaProfileStateCopyWithImpl<$Res, _$QiitaProfileStateImpl>
    implements _$$QiitaProfileStateImplCopyWith<$Res> {
  __$$QiitaProfileStateImplCopyWithImpl(_$QiitaProfileStateImpl _value,
      $Res Function(_$QiitaProfileStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? qiitaProfile = null,
  }) {
    return _then(_$QiitaProfileStateImpl(
      qiitaProfile: null == qiitaProfile
          ? _value.qiitaProfile
          : qiitaProfile // ignore: cast_nullable_to_non_nullable
              as AsyncValue<QiitaProfile>,
    ));
  }
}

/// @nodoc

class _$QiitaProfileStateImpl implements _QiitaProfileState {
  const _$QiitaProfileStateImpl({required this.qiitaProfile});

  @override
  final AsyncValue<QiitaProfile> qiitaProfile;

  @override
  String toString() {
    return 'QiitaProfileState(qiitaProfile: $qiitaProfile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QiitaProfileStateImpl &&
            (identical(other.qiitaProfile, qiitaProfile) ||
                other.qiitaProfile == qiitaProfile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, qiitaProfile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QiitaProfileStateImplCopyWith<_$QiitaProfileStateImpl> get copyWith =>
      __$$QiitaProfileStateImplCopyWithImpl<_$QiitaProfileStateImpl>(
          this, _$identity);
}

abstract class _QiitaProfileState implements QiitaProfileState {
  const factory _QiitaProfileState(
          {required final AsyncValue<QiitaProfile> qiitaProfile}) =
      _$QiitaProfileStateImpl;

  @override
  AsyncValue<QiitaProfile> get qiitaProfile;
  @override
  @JsonKey(ignore: true)
  _$$QiitaProfileStateImplCopyWith<_$QiitaProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
