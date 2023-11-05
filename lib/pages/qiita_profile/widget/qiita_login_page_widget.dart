import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/webview_provider.dart';
import '/api/qiita_auth.dart';
import '/pages/qiita_profile/service/inappwebview_cookie.dart';

class QiitaLoginPageWidget extends ConsumerWidget {
  const QiitaLoginPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final QiitaAuth qiitaAuth = QiitaAuth();
    InAppWebViewController? webViewController;
    final webViewNotifier = ref.read(webViewProvider.notifier);
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse(qiitaAuth.authorizeUrl)),
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      onLoadStart: (controller, url) async {
        // webViewNotifier.loading();
        if (url != null) {
          deleteCookies(url);
          if (url.toString().contains('/oauth/callback')) {
            qiitaAuth.login(url);
          }
        }
      },
      onLoadStop: (controller, url) async {
        // webViewNotifier.loaded();
        if (url.toString().startsWith('https://qiita.com/login')) {
          await controller.evaluateJavascript(source: """
        document.querySelector('.sessions-Registration_oauthWrapper').style.display = 'none';
        // Use the appropriate selector for the elements you want to hide or remove
      """);
        }
      },
      onLoadError: (controller, url, code, message) {
        print('error: $message');
        // webViewNotifier.loaded();
      },
    );
  }
}
