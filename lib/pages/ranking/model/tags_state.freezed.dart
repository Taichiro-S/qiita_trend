// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tags_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TagsState {
  AsyncValue<List<TagInfo>> get tags => throw _privateConstructorUsedError;
  DocumentSnapshot<Object?>? get lastDoc => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TagsStateCopyWith<TagsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagsStateCopyWith<$Res> {
  factory $TagsStateCopyWith(TagsState value, $Res Function(TagsState) then) =
      _$TagsStateCopyWithImpl<$Res, TagsState>;
  @useResult
  $Res call(
      {AsyncValue<List<TagInfo>> tags,
      DocumentSnapshot<Object?>? lastDoc,
      bool isLoadingMore});
}

/// @nodoc
class _$TagsStateCopyWithImpl<$Res, $Val extends TagsState>
    implements $TagsStateCopyWith<$Res> {
  _$TagsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
    Object? lastDoc = freezed,
    Object? isLoadingMore = null,
  }) {
    return _then(_value.copyWith(
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TagInfo>>,
      lastDoc: freezed == lastDoc
          ? _value.lastDoc
          : lastDoc // ignore: cast_nullable_to_non_nullable
              as DocumentSnapshot<Object?>?,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagsStateImplCopyWith<$Res>
    implements $TagsStateCopyWith<$Res> {
  factory _$$TagsStateImplCopyWith(
          _$TagsStateImpl value, $Res Function(_$TagsStateImpl) then) =
      __$$TagsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<List<TagInfo>> tags,
      DocumentSnapshot<Object?>? lastDoc,
      bool isLoadingMore});
}

/// @nodoc
class __$$TagsStateImplCopyWithImpl<$Res>
    extends _$TagsStateCopyWithImpl<$Res, _$TagsStateImpl>
    implements _$$TagsStateImplCopyWith<$Res> {
  __$$TagsStateImplCopyWithImpl(
      _$TagsStateImpl _value, $Res Function(_$TagsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
    Object? lastDoc = freezed,
    Object? isLoadingMore = null,
  }) {
    return _then(_$TagsStateImpl(
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<TagInfo>>,
      lastDoc: freezed == lastDoc
          ? _value.lastDoc
          : lastDoc // ignore: cast_nullable_to_non_nullable
              as DocumentSnapshot<Object?>?,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TagsStateImpl implements _TagsState {
  const _$TagsStateImpl(
      {required this.tags, required this.lastDoc, required this.isLoadingMore});

  @override
  final AsyncValue<List<TagInfo>> tags;
  @override
  final DocumentSnapshot<Object?>? lastDoc;
  @override
  final bool isLoadingMore;

  @override
  String toString() {
    return 'TagsState(tags: $tags, lastDoc: $lastDoc, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagsStateImpl &&
            (identical(other.tags, tags) || other.tags == tags) &&
            (identical(other.lastDoc, lastDoc) || other.lastDoc == lastDoc) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tags, lastDoc, isLoadingMore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagsStateImplCopyWith<_$TagsStateImpl> get copyWith =>
      __$$TagsStateImplCopyWithImpl<_$TagsStateImpl>(this, _$identity);
}

abstract class _TagsState implements TagsState {
  const factory _TagsState(
      {required final AsyncValue<List<TagInfo>> tags,
      required final DocumentSnapshot<Object?>? lastDoc,
      required final bool isLoadingMore}) = _$TagsStateImpl;

  @override
  AsyncValue<List<TagInfo>> get tags;
  @override
  DocumentSnapshot<Object?>? get lastDoc;
  @override
  bool get isLoadingMore;
  @override
  @JsonKey(ignore: true)
  _$$TagsStateImplCopyWith<_$TagsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
