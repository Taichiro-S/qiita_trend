import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/url.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class UserSettingsPage extends ConsumerWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.security),
                title: Text('Qiitaアカウント連携'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
            ],
          ),
        ],
      ),
      // Center(
      //     child: Padding(
      //         padding: const EdgeInsets.all(16),
      //         child: Column(
      //           children: [
      //             ElevatedButton(
      //                 onPressed: () async {
      //                   if (await canLaunchUrl(Uri.parse(PRIVACY_POLICY))) {
      //                     launchUrl(Uri.parse(PRIVACY_POLICY));
      //                   } else {
      //                     throw 'Could not launch $PRIVACY_POLICY';
      //                   }
      //                 },
      //                 child: const Text('プライバシーポリシー'))
      //           ],
      //         )))
    );
  }
}
