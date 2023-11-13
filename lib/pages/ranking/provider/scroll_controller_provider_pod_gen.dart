// import 'package:flutter/material.dart';
// import 'package:qiita_trend/pages/ranking/provider/loaded_tags_provider.dart';
// import 'package:qiita_trend/pages/user_settings/provider/property_provider.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'scroll_controller_provider_pod_gen.g.dart';

// @riverpod
// class ScrollControllerPodGen extends _$ScrollControllerPodGen {
//   @override
//   ScrollController build() {
//     final ScrollController controller = ScrollController();
//     controller.addListener(_scrollListener);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _fetchInitialDatas();
//     });
//     return controller;
//   }

//   void _fetchInitialDatas() {
//     final property = ref.read(propertyProvider);
//     ref.read(loadedTagsProvider.notifier).fetchRankedTags();
//   }

//   void _scrollListener() {
//     final controller = state;
//     if (controller.position.pixels == controller.position.maxScrollExtent) {
//       final property = ref.read(propertyProvider);
//       ref.read(loadedTagsProvider.notifier).fetchMoreRankedTags();
//     }
//   }
// }
