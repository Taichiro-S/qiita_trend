// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qiita_following_tags_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QiitaFollowingTagsState {
  AsyncValue<List<QiitaTag>> get followingTags =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QiitaFollowingTagsStateCopyWith<QiitaFollowingTagsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QiitaFollowingTagsStateCopyWith<$Res> {
  factory $QiitaFollowingTagsStateCopyWith(QiitaFollowingTagsState value,
          $Res Function(QiitaFollowingTagsState) then) =
      _$QiitaFollowingTagsStateCopyWithImpl<$Res, QiitaFollowingTagsState>;
  @useResult
  $Res call({AsyncValue<List<QiitaTag>> followingTags});
}

/// @nodoc
class _$QiitaFollowingTagsStateCopyWithImpl<$Res,
        $Val extends QiitaFollowingTagsState>
    implements $QiitaFollowingTagsStateCopyWith<$Res> {
  _$QiitaFollowingTagsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followingTags = null,
  }) {
    return _then(_value.copyWith(
      followingTags: null == followingTags
          ? _value.followingTags
          : followingTags // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<QiitaTag>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QiitaFollowingTagsStateImplCopyWith<$Res>
    implements $QiitaFollowingTagsStateCopyWith<$Res> {
  factory _$$QiitaFollowingTagsStateImplCopyWith(
          _$QiitaFollowingTagsStateImpl value,
          $Res Function(_$QiitaFollowingTagsStateImpl) then) =
      __$$QiitaFollowingTagsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<QiitaTag>> followingTags});
}

/// @nodoc
class __$$QiitaFollowingTagsStateImplCopyWithImpl<$Res>
    extends _$QiitaFollowingTagsStateCopyWithImpl<$Res,
        _$QiitaFollowingTagsStateImpl>
    implements _$$QiitaFollowingTagsStateImplCopyWith<$Res> {
  __$$QiitaFollowingTagsStateImplCopyWithImpl(
      _$QiitaFollowingTagsStateImpl _value,
      $Res Function(_$QiitaFollowingTagsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followingTags = null,
  }) {
    return _then(_$QiitaFollowingTagsStateImpl(
      followingTags: null == followingTags
          ? _value.followingTags
          : followingTags // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<QiitaTag>>,
    ));
  }
}

/// @nodoc

class _$QiitaFollowingTagsStateImpl implements _QiitaFollowingTagsState {
  const _$QiitaFollowingTagsStateImpl({required this.followingTags});

  @override
  final AsyncValue<List<QiitaTag>> followingTags;

  @override
  String toString() {
    return 'QiitaFollowingTagsState(followingTags: $followingTags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QiitaFollowingTagsStateImpl &&
            (identical(other.followingTags, followingTags) ||
                other.followingTags == followingTags));
  }

  @override
  int get hashCode => Object.hash(runtimeType, followingTags);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QiitaFollowingTagsStateImplCopyWith<_$QiitaFollowingTagsStateImpl>
      get copyWith => __$$QiitaFollowingTagsStateImplCopyWithImpl<
          _$QiitaFollowingTagsStateImpl>(this, _$identity);
}

abstract class _QiitaFollowingTagsState implements QiitaFollowingTagsState {
  const factory _QiitaFollowingTagsState(
          {required final AsyncValue<List<QiitaTag>> followingTags}) =
      _$QiitaFollowingTagsStateImpl;

  @override
  AsyncValue<List<QiitaTag>> get followingTags;
  @override
  @JsonKey(ignore: true)
  _$$QiitaFollowingTagsStateImplCopyWith<_$QiitaFollowingTagsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
