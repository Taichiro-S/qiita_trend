import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/user_settings/provider/property_provider.dart';
import 'package:qiita_trend/provider/qiita_auth_storage_provider.dart';
import 'package:qiita_trend/routes/router.dart';
import '/api/qiita_auth.dart';

@RoutePage()
class UserSettingsPage extends ConsumerWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProperty = ref.watch(propertyProvider);
    final propertyNotifier = ref.read(propertyProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: Column(
        children: <String>['itemsCount', 'followersCount']
            .map((String property) => RadioListTile<String>(
                  title: Text(property),
                  value: property,
                  groupValue: selectedProperty,
                  onChanged: (String? value) {
                    if (value != null) {
                      propertyNotifier.change(value);
                    }
                  },
                ))
            .toList(),
      ),
    );
  }
}
