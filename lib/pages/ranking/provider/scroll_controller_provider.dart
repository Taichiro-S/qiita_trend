import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/ranking/provider/property_provider.dart';
import 'package:qiita_trend/pages/ranking/provider/tags_notifier_provider.dart';

final scrollControllerProvider =
    StateNotifierProvider<ScrollControllerNotifier, ScrollController>(
  (ref) => ScrollControllerNotifier(ref),
);

class ScrollControllerNotifier extends StateNotifier<ScrollController> {
  final Ref ref;

  ScrollControllerNotifier(this.ref) : super(ScrollController()) {
    state.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchInitialTags();
    });
  }

  void _fetchInitialTags() {
    final property = ref.read(propertyProvider);
    ref.read(tagsProvider.notifier).fetchTags(
          fieldOrderBy: property == 'itemsCount'
              ? TagsField.itemsCount
              : TagsField.followersCount,
        );
  }

  void _scrollListener() {
    if (state.position.pixels == state.position.maxScrollExtent) {
      final property = ref.read(propertyProvider);
      ref.read(tagsProvider.notifier).fetchMoreTags(
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
