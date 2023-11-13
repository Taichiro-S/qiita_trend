// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:qiita_trend/pages/ranking/model/ranked_tag.dart';
// import 'package:qiita_trend/pages/ranking/provider/tag_changes_provider.dart';

// class TagChangesWidget extends ConsumerWidget {
//   final RankedTag rankedTag;
//   const TagChangesWidget({super.key, required this.rankedTag});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tagChanges = ref.watch(tagChangesProvider(id: rankedTag.id));
//     return tagChanges.when(
//       data: (tagChanges) {
//         // Convert TagChange data to FlSpot list for the chart
//         final spots = tagChanges.map<FlSpot>((tagChange) {
//           final x =
//               tagChange.createdAt.toDate().millisecondsSinceEpoch.toDouble();
//           final y = double.tryParse(tagChange.itemsChange) ?? 0;
//           return FlSpot(x, y);
//         }).toList();

//         // Create the LineChart
//         final lineChart = LineChart(
//           LineChartData(
//             gridData: const FlGridData(show: true),
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 30,
//                   getTitlesWidget: (value, meta) {
//                     // Format the value to a date or any other string
//                     final DateTime date =
//                         DateTime.fromMillisecondsSinceEpoch(value.toInt());
//                     final String text = DateFormat.d().format(date);

//                     return SideTitleWidget(
//                       axisSide: meta.axisSide,
//                       space:
//                           8.0, // the space between the side title and the chart
//                       child: Text(text),
//                     );
//                   },
//                 ),
//               ),
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: false,
//                   reservedSize: 40,
//                   getTitlesWidget: (value, meta) {
//                     // Format the value to a string
//                     final String text =
//                         value.toStringAsFixed(1); // One decimal place

//                     return SideTitleWidget(
//                       axisSide: meta.axisSide,
//                       space:
//                           8.0, // the space between the side title and the chart
//                       child: Text(text),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             borderData: FlBorderData(show: true),
//             lineBarsData: [
//               LineChartBarData(
//                 spots: spots,
//                 isCurved: false,
//                 barWidth: 2,
//                 isStrokeCapRound: true,
//                 dotData: const FlDotData(show: false),
//                 belowBarData: BarAreaData(show: false),
//               ),
//             ],
//           ),
//         );

//         return SizedBox(
//           height: 300,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: lineChart,
//           ),
//         );
//       },
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (e, s) {
//         debugPrint(e.toString());
//         return Text(e.toString());
//       },
//     );
//   }
// }
