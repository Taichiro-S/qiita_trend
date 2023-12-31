import 'package:flutter/material.dart';
import 'package:qiita_trend/pages/display_settings/provider/display_settings_provider.dart';
import 'package:qiita_trend/pages/ranking/provider/loaded_tags_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scroll_controller_provider.g.dart';

@riverpod
class ScrollControllerNotifier extends _$ScrollControllerNotifier {
  @override
  ScrollController build() {
    final ScrollController controller = ScrollController();
    controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialDatas();
    });
    return controller;
  }

  void _fetchInitialDatas() {
    final displaySettings = ref.read(displaySettingsProvider);
    ref.read(loadedTagsProvider.notifier).fetchRankedTags(
        timePeriod: displaySettings.timePeriod,
        sortOrder: displaySettings.sortOrder);
  }

  void _scrollListener() {
    if (state.position.pixels == state.position.maxScrollExtent) {
      final displaySettings = ref.read(displaySettingsProvider);

      ref.read(loadedTagsProvider.notifier).fetchMoreRankedTags(
          timePeriod: displaySettings.timePeriod,
          sortOrder: displaySettings.sortOrder);
    }
  }
}
