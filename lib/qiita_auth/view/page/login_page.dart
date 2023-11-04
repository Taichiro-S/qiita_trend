import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_trend/qiita_auth/api/qiita_auth.dart';
import 'package:qiita_trend/qiita_auth/provider/uuid_provider.dart';
import 'package:qiita_trend/routes/router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/qiita_auth/provider/login_url_provider.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uuid = ref.watch(uuidProvider);
    const scope = 'read_qiita write_qiita';
    final clientId = dotenv.env['QIITA_CLIENT_ID'];
    final clientSecret = dotenv.env['QIITA_CLIENT_SECRET'];
    if (clientId == null || clientSecret == null) {
      throw Exception('clientId or clientSecret is null');
    }
    final qiitaAuth = QiitaAuth(clientId, clientSecret, uuid, scope);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Qiita Auth'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).push(const RankingRoute());
                },
                child: const Text('タグ数の推移'),
              ),
              ElevatedButton(
                onPressed: () {
                  qiitaAuth.authorize();
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ));
  }
}
