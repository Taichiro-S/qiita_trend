import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/ranking/widget/test_chart.dart';
import 'package:qiita_trend/pages/user_settings/provider/property_provider.dart';
import 'package:qiita_trend/pages/ranking/widget/tag_changes_widget.dart';
import '/pages/ranking/model/tag_info.dart';
import '/pages/ranking/widget/bar_indicator_widget.dart';

class TagContainerWidget extends ConsumerWidget {
  const TagContainerWidget({super.key, required this.tag});
  final TagInfo tag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final property = ref.watch(propertyProvider);
    final itemsCount = int.parse(tag.itemsCount);
    final followersCount = int.parse(tag.followersCount);
    String displayItemsCount;
    String displayFollowersCount;
    if (itemsCount > 1000) {
      displayItemsCount = (itemsCount / 1000).toStringAsFixed(1) + 'k';
    } else {
      displayItemsCount = itemsCount.toString();
    }
    if (followersCount > 1000) {
      displayFollowersCount = (followersCount / 1000).toStringAsFixed(1) + 'k';
    } else {
      displayFollowersCount = followersCount.toString();
    }

    return Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white70,
            backgroundImage: tag.iconUrl != null
                ? NetworkImage(tag.iconUrl!)
                : const AssetImage('assets/images/no_image.png')
                    as ImageProvider<Object>,
            radius: 20,
          ),
          title: Text(
            tag.id,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            children: [
              property == 'itemsCount'
                  ? Row(children: [
                      const Icon(
                        Icons.description,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      BarIndicator(
                          value: itemsCount, property: 'maxItemsCount'),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        displayItemsCount,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ])
                  : property == 'followersCount'
                      ? Row(children: [
                          const Icon(
                            Icons.person,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          BarIndicator(
                              value: followersCount,
                              property: 'maxFollowersCount'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            displayFollowersCount,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ])
                      : const SizedBox(),
              // TagChangesWidget(tag: tag)
              const TestChart()
            ],
          ),
        ));
  }
}
