import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/provider/qiita_auth_provider.dart';
import 'package:qiita_trend/routes/router.dart';
import '/api/qiita_auth.dart';

@RoutePage()
class UserSettingsPage extends ConsumerWidget {
  const UserSettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Settings"),
      ),
      body: const Center(child: Text('ユーザ設定')),
    );
  }
}
