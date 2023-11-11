import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/ranking/provider/loaded_tags_provider.dart';
import 'package:qiita_trend/pages/user_settings/provider/property_provider.dart';

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
    final property = ref.read(propertyProvider);
    ref.read(loadedTagsProvider.notifier).fetchTags(
          fieldOrderBy: property == 'itemsCount'
              ? TagsField.itemsCount
              : TagsField.followersCount,
        );
  }

  void _scrollListener() {
    if (state.position.pixels == state.position.maxScrollExtent) {
      final property = ref.read(propertyProvider);
      ref.read(loadedTagsProvider.notifier).fetchMoreTags(
            fieldOrderBy: property == 'itemsCount'
                ? TagsField.itemsCount
                : TagsField.followersCount,
          );
    }
  }

  @override
  void dispose() {
    state.removeListener(_scrollListener);
    super.dispose();
  }
}
