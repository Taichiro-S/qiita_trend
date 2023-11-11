import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/ranking/provider/scroll_controller_provider.dart';
import 'package:qiita_trend/pages/user_settings/provider/property_provider.dart';
import 'package:qiita_trend/routes/router.dart';
import 'package:qiita_trend/widget/circle_loading_widget.dart';

import '/pages/ranking/provider/loaded_tags_provider.dart';
import 'widget/tag_container_widget.dart';

@RoutePage()
class RankingPage extends ConsumerWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollControllerProvider);
    final loadedTagsAsync = ref.watch(loadedTagsProvider);
    final selectedpPoperty = ref.watch(propertyProvider);
    final router = AutoRouter.of(context);

    ref.listen<String>(propertyProvider, (previousState, state) {
      if (state != previousState) {
        ref.read(loadedTagsProvider.notifier).fetchTags(
            fieldOrderBy: state == 'itemsCount'
                ? TagsField.itemsCount
                : TagsField.followersCount);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('タグランキング'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              router.push(const UserSettingsRoute());
            },
          ),
        ],
      ),
      body: loadedTagsAsync.tags.when(
        loading: () => const Center(
            child: CircleLoadingWidget(color: Colors.green, fontSize: 20)),
        error: (error, stack) => Center(child: Text('エラー: $error')),
        data: (tags) {
          return RefreshIndicator(
            child: ListView.builder(
              controller: scrollController,
              itemCount: tags.length + (loadedTagsAsync.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (loadedTagsAsync.isLoadingMore && index == tags.length) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.green,
                  ));
                }

                final tag = tags[index];
                return TagContainerWidget(tag: tag);
              },
            ),
            onRefresh: () async {
              ref.read(loadedTagsProvider.notifier).fetchTags(
                  fieldOrderBy: selectedpPoperty == 'itemsCount'
                      ? TagsField.itemsCount
                      : TagsField.followersCount);
            },
          );
        },
      ),
    );
  }
}
