import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/ranking/provider/max_value_provider.dart';

class BarIndicator extends ConsumerWidget {
  final int value;
  final Color color;
  final String property;
  const BarIndicator({
    Key? key,
    required this.value,
    required this.property,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxValueAsync = ref.watch(maxValueProvider);
    final double maxWidth = MediaQuery.of(context).size.width - 200;

    return Container(
        child: maxValueAsync.when(
      data: (maxValue) {
        final double ratio = value / (maxValue[property]! * 1.0);
        return Container(
          width: maxWidth * ratio,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (e, s) {
        debugPrint(e.toString());
        return Text(e.toString());
      },
    ));
  }
}
