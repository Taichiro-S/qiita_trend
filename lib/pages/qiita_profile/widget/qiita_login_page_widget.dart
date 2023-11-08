import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/webview_provider.dart';
import 'package:qiita_trend/provider/qiita_auth_storage_provider.dart';
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
        print(url);
        // print(qiitaAuth.authorizeUrl);
        // webViewNotifier.loading();
        if (url != null) {
          await deleteCookies(url);
          if (url.toString().contains('/oauth/callback')) {
            await qiitaAuth.login(url);
            webViewNotifier.hide();
            ref.invalidate(qiitaAuthStorageProvider);
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
        print('onLoadError: $message');
        print(url);
        // webViewNotifier.loaded();
      },
    );
  }
}
