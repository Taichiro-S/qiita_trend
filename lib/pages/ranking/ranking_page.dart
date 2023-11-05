import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/pages/ranking/provider/tags_provider.dart';
import '/pages/ranking//widget/tag_container.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class RankingPage extends ConsumerWidget {
  const RankingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicAsync = ref.watch(tagsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('タグ一覧'),
      ),
      body: topicAsync.when(
        error: (e, s) => Text(e.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (tags) {
          return ListView.builder(
            itemCount: tags.length,
            itemBuilder: (context, index) {
              final tag = tags[index];
              return TagContainer(tag: tag);
            },
          );
        },
      ),
    );
  }
}
