import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_trend/constant/default_values.dart';
import 'package:qiita_trend/constant/url.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

// @RoutePage()
class TestAPage extends StatefulWidget {
  const TestAPage({super.key});
  @override
  State<TestAPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestAPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    final String clientId = dotenv.env['QIITA_CLIENT_ID']!;
    final String state = const Uuid().v4();
    const String scope = QIITA_SCOPE;
    final url = Uri.https(QIITA_BASE_URL, QIITA_API_V2_AUTHORIZE, {
      'client_id': clientId,
      'scope': scope,
      'state': state,
      'response_type': 'code',
    });
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(url.toString()),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WebViewWidget(controller: controller));
  }
}
