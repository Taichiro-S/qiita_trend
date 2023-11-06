import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/pages/ranking/provider/tags_notifier_provider.dart';
import 'widget/tag_container_widget.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class RankingPage extends ConsumerStatefulWidget {
  const RankingPage({super.key});

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends ConsumerState<RankingPage> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(tagsProvider.notifier).fetchTags(),
    );
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      ref.read(tagsProvider.notifier).fetchMoreTags();
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
    final tagsAsync = ref.watch(tagsProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('タグ一覧'),
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
                  ref.read(tagsProvider.notifier).refreshTags();
                },
              );
            }));
  }
}
