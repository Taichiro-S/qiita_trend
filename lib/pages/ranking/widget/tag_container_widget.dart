import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/default_value.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/display_settings/provider/display_settings_provider.dart';
import 'package:qiita_trend/pages/ranking/model/ranked_tag.dart';
import 'package:qiita_trend/pages/ranking/service/display_num.dart';
import 'package:qiita_trend/pages/ranking/widget/tag_history_widget.dart';
import 'package:qiita_trend/pages/ranking/widget/test_chart.dart';
import '/pages/ranking/widget/bar_indicator_widget.dart';

class TagContainerWidget extends ConsumerWidget {
  const TagContainerWidget({super.key, required this.rankedTag});
  final RankedTag rankedTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displaySettings = ref.watch(displaySettingsProvider);
    String displayItemsCount = displayNum(rankedTag.itemsCount);
    String displayFollowersCount = displayNum(rankedTag.followersCount);
    String displayItemsCountChange = displayNum(rankedTag.itemsCountChange);
    String displayFollowersCountChange =
        displayNum(rankedTag.followersCountChange);
    return ListTile(
      leading: Column(children: [
        CircleAvatar(
          backgroundColor: Colors.white70,
          backgroundImage: rankedTag.iconUrl != null
              ? CachedNetworkImageProvider(rankedTag.iconUrl!)
              : const AssetImage('assets/images/no_image.png')
                  as ImageProvider<Object>,
          radius: 20,
        )
      ]),
      title: Text(
        rankedTag.id,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        children: [
          displaySettings.sortOrder == RankedTagsSortOrder.itemsCount
              ? BarIndicator(
                  value: rankedTag.itemsCount.toDouble(),
                  displayCount: displayItemsCount)
              : displaySettings.sortOrder == RankedTagsSortOrder.followersCount
                  ? BarIndicator(
                      value: rankedTag.followersCount.toDouble(),
                      displayCount: displayFollowersCount)
                  : displaySettings.sortOrder ==
                          RankedTagsSortOrder.itemsCountChange
                      ? BarIndicator(
                          value: rankedTag.itemsCountChange.toDouble(),
                          displayCount: displayItemsCountChange)
                      : BarIndicator(
                          value: rankedTag.followersCountChange.toDouble(),
                          displayCount: displayFollowersCountChange),
        ],
      ),
    );
  }
}
