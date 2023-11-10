// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loaded_tag_changes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoadedTagChangesState {
  AsyncValue<List<TagChange>> get tagChanges =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoadedTagChangesStateCopyWith<LoadedTagChangesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadedTagChangesStateCopyWith<$Res> {
  factory $LoadedTagChangesStateCopyWith(LoadedTagChangesState value,
          $Res Function(LoadedTagChangesState) then) =
      _$LoadedTagChangesStateCopyWithImpl<$Res, LoadedTagChangesState>;
  @useResult
  $Res call({AsyncValue<List<TagChange>> tagChanges});
}

/// @nodoc
class _$LoadedTagChangesStateCopyWithImpl<$Res,
        $Val extends LoadedTagChangesState>
    implements $LoadedTagChangesStateCopyWith<$Res> {
  _$LoadedTagChangesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagChanges = null,
  }) {
    return _then(_value.copyWith(
      tagChanges: null == tagChanges
          ? _value.tagChanges
          : tagChanges // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TagChange>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadedTagChangesStateImplCopyWith<$Res>
    implements $LoadedTagChangesStateCopyWith<$Res> {
  factory _$$LoadedTagChangesStateImplCopyWith(
          _$LoadedTagChangesStateImpl value,
          $Res Function(_$LoadedTagChangesStateImpl) then) =
      __$$LoadedTagChangesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AsyncValue<List<TagChange>> tagChanges});
}

/// @nodoc
class __$$LoadedTagChangesStateImplCopyWithImpl<$Res>
    extends _$LoadedTagChangesStateCopyWithImpl<$Res,
        _$LoadedTagChangesStateImpl>
    implements _$$LoadedTagChangesStateImplCopyWith<$Res> {
  __$$LoadedTagChangesStateImplCopyWithImpl(_$LoadedTagChangesStateImpl _value,
      $Res Function(_$LoadedTagChangesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagChanges = null,
  }) {
    return _then(_$LoadedTagChangesStateImpl(
      tagChanges: null == tagChanges
          ? _value.tagChanges
          : tagChanges // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TagChange>>,
    ));
  }
}

/// @nodoc

class _$LoadedTagChangesStateImpl implements _LoadedTagChangesState {
  const _$LoadedTagChangesStateImpl({required this.tagChanges});

  @override
  final AsyncValue<List<TagChange>> tagChanges;

  @override
  String toString() {
    return 'LoadedTagChangesState(tagChanges: $tagChanges)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedTagChangesStateImpl &&
            (identical(other.tagChanges, tagChanges) ||
                other.tagChanges == tagChanges));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tagChanges);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedTagChangesStateImplCopyWith<_$LoadedTagChangesStateImpl>
      get copyWith => __$$LoadedTagChangesStateImplCopyWithImpl<
          _$LoadedTagChangesStateImpl>(this, _$identity);
}

abstract class _LoadedTagChangesState implements LoadedTagChangesState {
  const factory _LoadedTagChangesState(
          {required final AsyncValue<List<TagChange>> tagChanges}) =
      _$LoadedTagChangesStateImpl;

  @override
  AsyncValue<List<TagChange>> get tagChanges;
  @override
  @JsonKey(ignore: true)
  _$$LoadedTagChangesStateImplCopyWith<_$LoadedTagChangesStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
