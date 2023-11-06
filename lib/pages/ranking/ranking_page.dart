import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/ranking/provider/property_provider.dart';
import 'package:qiita_trend/routes/router.dart';
import '/pages/ranking/provider/tags_notifier_provider.dart';
import 'widget/tag_container_widget.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class RankingPage extends ConsumerStatefulWidget {
  const RankingPage({super.key});

  @override
  RankingPageState createState() => RankingPageState();
}

class RankingPageState extends ConsumerState<RankingPage> {
  final ScrollController scrollController = ScrollController();
  late String property;
  @override
  void initState() {
    super.initState();
    property = ref.watch(propertyProvider);
    Future.microtask(
      () => ref.read(tagsProvider.notifier).fetchTags(
          fieldOrderBy: property == 'itemsCount'
              ? TagsField.itemsCount
              : TagsField.followersCount),
    );
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      ref.read(tagsProvider.notifier).fetchMoreTags(
          fieldOrderBy: property == 'itemsCount'
              ? TagsField.itemsCount
              : TagsField.followersCount);
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final tagsAsync = ref.watch(tagsProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('タグ一覧'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // AutoRouteを使用している場合は以下のように書きます
                router.push(const UserSettingsRoute());
              },
            ),
          ],
        ),
        body: tagsAsync.tags.when(
            error: (e, s) {
              debugPrint(e.toString());
              return Text(e.toString());
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (tags) {
              return RefreshIndicator(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: tags.length + (tagsAsync.isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (tagsAsync.isLoadingMore && index == tags.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final tag = tags[index];
                    return TagContainerWidget(tag: tag);
                  },
                ),
                onRefresh: () async {
                  ref.read(tagsProvider.notifier).refreshTags(
                      fieldOrderBy: property == 'itemsCount'
                          ? TagsField.itemsCount
                          : TagsField.followersCount);
                },
              );
            }));
  }
}
