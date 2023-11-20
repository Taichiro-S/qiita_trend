import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_trend/pages/qiita_profile/model/qiita_profile.dart';

part 'qiita_profile_state.freezed.dart';

@freezed
class QiitaProfileState with _$QiitaProfileState {
  const factory QiitaProfileState({
    required AsyncValue<QiitaProfile> qiitaProfile,
  }) = _QiitaProfileState;
}
