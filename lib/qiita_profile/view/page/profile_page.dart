// File: my_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/qiita_profile/provider/qiita_profile_provider.dart';

@RoutePage()
class QiitaProfilePage extends ConsumerWidget {
  const QiitaProfilePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qiitaProfileAsync = ref.watch(qiitaProfileProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proflie"),
      ),
      body: qiitaProfileAsync.when(
        error: (e, s) => Text(e.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (qiitProfile) {
          return Center(child: Text('userame: ${qiitProfile.name}'));
        },
      ),
    );
  }
}
