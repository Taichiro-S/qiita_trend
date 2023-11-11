import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/url.dart';
import 'package:qiita_trend/pages/user_settings/provider/property_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
          children: [
            Column(
              children: <String>['itemsCount', 'followersCount']
                  .map((property) => RadioListTile<String>(
                        title: Text(property),
                        value: property,
                        groupValue: selectedProperty,
                        onChanged: (value) {
                          if (value != null) {
                            propertyNotifier.change(value);
                          }
                        },
                      ))
                  .toList(),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (await canLaunchUrl(Uri.parse(PRIVACY_POLICY))) {
                    launchUrl(Uri.parse(PRIVACY_POLICY));
                  } else {
                    throw 'Could not launch $PRIVACY_POLICY';
                  }
                },
                child: const Text('プライバシーポリシー'))
          ],
        ));
  }
}
