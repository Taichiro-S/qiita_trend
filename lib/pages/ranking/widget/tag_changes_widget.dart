import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/ranking/provider/tag_changes_provider.dart';
import '/pages/ranking/model/tag_info.dart';

class TagChangesWidget extends ConsumerWidget {
  final TagInfo tag;
  const TagChangesWidget({super.key, required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagChanges = ref.watch(tagChangesProvider(id: tag.id));
    return tagChanges.when(
      data: (tagChanges) {
        return ListView.builder(
          itemCount: tagChanges.length,
          itemBuilder: (context, index) {
            final tagChange = tagChanges[index];
            return ListTile(
              title: Text((tagChange.itemsChange).toString()),
              subtitle: Text(tagChange.itemsCount.toString()),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) {
        debugPrint(e.toString());
        return Text(e.toString());
      },
    );
  }
}
