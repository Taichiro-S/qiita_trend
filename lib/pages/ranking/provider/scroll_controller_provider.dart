import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/display_settings/provider/display_settings_provider.dart';
import 'package:qiita_trend/pages/ranking/provider/loaded_tags_provider.dart';

final scrollControllerProvider =
    StateNotifierProvider<ScrollControllerNotifier, ScrollController>(
  (ref) => ScrollControllerNotifier(ref),
);

class ScrollControllerNotifier extends StateNotifier<ScrollController> {
  final Ref ref;

  ScrollControllerNotifier(this.ref) : super(ScrollController()) {
    state.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialDatas();
    });
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

  @override
  void dispose() {
    state.removeListener(_scrollListener);
    super.dispose();
  }
}
