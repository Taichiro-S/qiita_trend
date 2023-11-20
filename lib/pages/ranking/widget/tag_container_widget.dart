import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/ranking/model/ranked_tag.dart';
import 'package:qiita_trend/pages/ranking/provider/display_settings_provider.dart';
import 'package:qiita_trend/pages/ranking/service/display_num.dart';
import 'package:qiita_trend/pages/ranking/widget/favorite_icon_widget.dart';

import '/pages/ranking/widget/bar_indicator_widget.dart';

class TagContainerWidget extends ConsumerWidget {
  const TagContainerWidget(
      {super.key, required this.rankedTag, required this.index});
  final RankedTag rankedTag;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displaySettings = ref.watch(displaySettingsProvider);
    return ListTile(
      leading: Column(children: [
        /* TODO
        Handle 403 exception
        */
        CircleAvatar(
          backgroundColor: Colors.white70,
          backgroundImage: rankedTag.iconUrl != null
              ? CachedNetworkImageProvider(rankedTag.iconUrl!)
              : const AssetImage('assets/images/no_image.png')
                  as ImageProvider<Object>,
          radius: 16,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text((index + 1).toString(),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ))
      ]),
      title: Row(children: <Widget>[
        Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            strutStyle: const StrutStyle(fontSize: 12.0),
            text: TextSpan(
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                text: rankedTag.id),
          ),
        ),
        FavoriteIconWidget(rankedTag: rankedTag),
        IconButton(
            onPressed: () async {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) => ArticlesInfoPage(
              //               topicId: rankedTopic.id,
              //             )));
              // if (await canLaunchUrl(uri)) {
              //   launchUrl(uri);
              // }
            },
            icon: displaySettings.sortOrder == RankedTagsSortOrder.itemsCount ||
                    displaySettings.sortOrder ==
                        RankedTagsSortOrder.itemsCountChange
                ? const Icon(
                    Icons.description,
                    size: 20,
                  )
                : const Icon(
                    Icons.person,
                    size: 20,
                  ))
      ]),
      subtitle: Column(
        children: [
          BarIndicator(
            value: displaySettings.sortOrder == RankedTagsSortOrder.itemsCount
                ? rankedTag.itemsCount.toDouble()
                : displaySettings.sortOrder ==
                        RankedTagsSortOrder.followersCount
                    ? rankedTag.followersCount.toDouble()
                    : displaySettings.sortOrder ==
                            RankedTagsSortOrder.itemsCountChange
                        ? rankedTag.itemsCountChange.toDouble()
                        : rankedTag.followersCountChange.toDouble(),
            displayCount:
                displaySettings.sortOrder == RankedTagsSortOrder.itemsCount
                    ? displayNum(rankedTag.itemsCount)
                    : displaySettings.sortOrder ==
                            RankedTagsSortOrder.followersCount
                        ? displayNum(rankedTag.followersCount)
                        : displaySettings.sortOrder ==
                                RankedTagsSortOrder.itemsCountChange
                            ? displayNum(rankedTag.itemsCountChange)
                            : displayNum(rankedTag.followersCountChange),
          )
        ],
      ),
    );
  }
}
