import 'package:qiita_trend/constant/default_value.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/display_settings/model/display_settings_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'display_settings_provider.g.dart';

@riverpod
class DisplaySettings extends _$DisplaySettings {
  @override
  DisplaySettingsState build() {
    return const DisplaySettingsState(
        timePeriod: DEFAULT_TIME_PERIOD, sortOrder: DEFAULT_SORT_ORDER);
  }

  void changeTimePeriod(Collection timePeriod) {
    state = state.copyWith(timePeriod: timePeriod);
  }

  void changeSortOrder(RankedTagsSortOrder sortOrder) {
    state = state.copyWith(sortOrder: sortOrder);
  }

  void toggleTimePeriod(int index) {
    if (index == 0) {
      state = state.copyWith(timePeriod: Collection.weeklyRanking);
    } else {
      state = state.copyWith(timePeriod: Collection.monthlyRanking);
    }
  }

  void toggleSortOrder(int index) {
    if (index == 0) {
      state = state.copyWith(sortOrder: RankedTagsSortOrder.itemsCountChange);
    } else {
      state =
          state.copyWith(sortOrder: RankedTagsSortOrder.follwersCountChange);
    }
  }
}
