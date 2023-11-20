import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/qiita_following_tags_provider.dart';

class QiitaFollowingTagsWidhet extends ConsumerWidget {
  const QiitaFollowingTagsWidhet({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qiitaFollowingTags = ref.watch(qiitaFollowingTagsProvider);
    return qiitaFollowingTags.followingTags.when(data: (tags) {
      return Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              Icon(
                Icons.tag,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Following Tags",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: tags
                .map((tag) => Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        tag.id,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ))
                .toList(),
          ),
        ],
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, error: (error, stackTrace) {
      return const Center(
        child: Text("Error"),
      );
    });
  }
}
