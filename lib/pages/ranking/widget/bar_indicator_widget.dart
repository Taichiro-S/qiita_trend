import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/ranking/provider/display_settings_provider.dart';
import 'package:qiita_trend/pages/ranking/provider/loaded_tags_provider.dart';

class BarIndicator extends ConsumerWidget {
  final double value;
  final String displayCount;
  final Color color;
  const BarIndicator({
    Key? key,
    required this.value,
    required this.displayCount,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadedTagsAsync = ref.watch(loadedTagsProvider);
    final double maxWidth = MediaQuery.of(context).size.width - 150;
    final displaySettings = ref.watch(displaySettingsProvider);

    return Container(
        child: loadedTagsAsync.rankedTags.when(
      data: (tags) {
        int maxValue = 0;

        if (displaySettings.sortOrder == RankedTagsSortOrder.followersCount) {
          for (var i = 0; i < tags.length; i++) {
            if (tags[i].followersCount > maxValue) {
              maxValue = tags[i].followersCount;
            }
          }
        } else if (displaySettings.sortOrder ==
            RankedTagsSortOrder.itemsCount) {
          for (var i = 0; i < tags.length; i++) {
            if (tags[i].itemsCount > maxValue) {
              maxValue = tags[i].itemsCount;
            }
          }
        } else if (displaySettings.sortOrder ==
            RankedTagsSortOrder.itemsCountChange) {
          for (var i = 0; i < tags.length; i++) {
            if (tags[i].itemsCountChange > maxValue) {
              maxValue = tags[i].itemsCountChange;
            }
          }
        } else {
          for (var i = 0; i < tags.length; i++) {
            if (tags[i].followersCountChange > maxValue) {
              maxValue = tags[i].followersCountChange;
            }
          }
        }
        final double ratio = value / (maxValue * 1.0);
        return Row(children: [
          const SizedBox(
            width: 5,
          ),
          Container(
            width: maxWidth * ratio,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            displayCount,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          )
        ]);
      },
      loading: () => Flexible(
        fit: FlexFit.loose,
        child: LinearProgressIndicator(
          color: color,
        ),
      ),
      error: (e, s) {
        return Text(e.toString());
      },
    ));
  }
}
