import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qiita_trend/pages/ranking/model/ranked_tag.dart';

class TagHistoryWidget extends ConsumerWidget {
  final RankedTag rankedTag;
  const TagHistoryWidget({super.key, required this.rankedTag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
