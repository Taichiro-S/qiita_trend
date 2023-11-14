import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qiita_trend/constant/default_value.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/main.dart';
import 'package:qiita_trend/pages/display_settings/provider/display_settings_provider.dart';
import 'package:qiita_trend/pages/ranking/model/ranked_tag.dart';
import 'package:qiita_trend/pages/ranking/model/tag_history_state.dart';
import 'package:qiita_trend/theme/app_colors.dart';

class TagHistoryWidget extends ConsumerWidget {
  final RankedTag rankedTag;
  const TagHistoryWidget({super.key, required this.rankedTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displaySettings = ref.watch(displaySettingsProvider);
    List<TagHistoryState> dataset = rankedTag.itemsCountHistory!;
    if (displaySettings.sortOrder == RankedTagsSortOrder.itemsCountChange) {
      if (rankedTag.itemsCountHistory == null) {
        return Container();
      }
      dataset = rankedTag.itemsCountHistory!;
    } else if (displaySettings.sortOrder ==
        RankedTagsSortOrder.follwersCountChange) {
      if (rankedTag.followersCountHistory == null) {
        return Container();
      }
      dataset = rankedTag.followersCountHistory!;
    }
    return Stack(
      children: <Widget>[
        const Text('グラフ'),
        AspectRatio(
          aspectRatio: 1.50,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
              top: 10,
              bottom: 10,
            ),
            child: LineChart(mainData(dataset)),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(List<TagHistoryState> dataset) {
    List<Color> gradientColors = [
      AppColors.light().secondary,
      AppColors.light().primary,
    ];
    List<FlSpot> spots = [];
    double maxY = 0.0;
    double minY = 0.0;
    double cumulativeY = 0;
    for (var i = 0; i < dataset.length; i++) {
      final history = dataset[i];
      final x = i.toDouble();
      cumulativeY += history.change.toDouble();
      if (cumulativeY > maxY) {
        maxY = cumulativeY;
      }
      if (cumulativeY < minY) {
        minY = cumulativeY;
      }
      spots.add(FlSpot(x, cumulativeY));
    }
    List<DateTime> dates = dataset
        .map((history) => history.date.toDate()) // TimestampからDateTimeに変換
        .toList();
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              // リストの範囲外のインデックスを防ぐ
              if (index < 0 || index >= dates.length) {
                return const Text('');
              }
              final date = dates[index];
              final dateString = DateFormat('MM/d').format(date);
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  dateString,
                  style: const TextStyle(fontSize: 12),
                ),
              );
            },
            reservedSize: 30,
            interval: 1,
          ),
        ),
        // rightTitles: const AxisTitles(
        //   sideTitles: SideTitles(showTitles: false),
        // ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 50,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              if (value == maxY || value == minY) {
                return const Text('');
              }
              return Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ));
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(),
      ),
      minX: 0,
      maxX: 6,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          barWidth: 5,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              )),
        ),
      ],
    );
  }
}
