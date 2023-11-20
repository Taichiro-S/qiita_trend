import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
part 'display_settings_state.freezed.dart';

@freezed
class DisplaySettingsState with _$DisplaySettingsState {
  const factory DisplaySettingsState({
    required Collection timePeriod,
    required RankedTagsSortOrder sortOrder,
    required bool showChart,
  }) = _DisplaySettingsState;
}
