// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TagHistory {
  Timestamp get date => throw _privateConstructorUsedError;
  int get change => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TagHistoryCopyWith<TagHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TagHistoryCopyWith<$Res> {
  factory $TagHistoryCopyWith(
          TagHistory value, $Res Function(TagHistory) then) =
      _$TagHistoryCopyWithImpl<$Res, TagHistory>;
  @useResult
  $Res call({Timestamp date, int change});
}

/// @nodoc
class _$TagHistoryCopyWithImpl<$Res, $Val extends TagHistory>
    implements $TagHistoryCopyWith<$Res> {
  _$TagHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? change = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TagHistoryImplCopyWith<$Res>
    implements $TagHistoryCopyWith<$Res> {
  factory _$$TagHistoryImplCopyWith(
          _$TagHistoryImpl value, $Res Function(_$TagHistoryImpl) then) =
      __$$TagHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Timestamp date, int change});
}

/// @nodoc
class __$$TagHistoryImplCopyWithImpl<$Res>
    extends _$TagHistoryCopyWithImpl<$Res, _$TagHistoryImpl>
    implements _$$TagHistoryImplCopyWith<$Res> {
  __$$TagHistoryImplCopyWithImpl(
      _$TagHistoryImpl _value, $Res Function(_$TagHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? change = null,
  }) {
    return _then(_$TagHistoryImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TagHistoryImpl with DiagnosticableTreeMixin implements _TagHistory {
  const _$TagHistoryImpl({required this.date, required this.change});

  @override
  final Timestamp date;
  @override
  final int change;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TagHistory(date: $date, change: $change)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TagHistory'))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('change', change));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TagHistoryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.change, change) || other.change == change));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, change);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TagHistoryImplCopyWith<_$TagHistoryImpl> get copyWith =>
      __$$TagHistoryImplCopyWithImpl<_$TagHistoryImpl>(this, _$identity);
}

abstract class _TagHistory implements TagHistory {
  const factory _TagHistory(
      {required final Timestamp date,
      required final int change}) = _$TagHistoryImpl;

  @override
  Timestamp get date;
  @override
  int get change;
  @override
  @JsonKey(ignore: true)
  _$$TagHistoryImplCopyWith<_$TagHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
