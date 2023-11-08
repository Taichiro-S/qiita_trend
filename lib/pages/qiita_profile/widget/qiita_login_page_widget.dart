import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/uuid_provider.dart';
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
    final state = ref.read(uuidProvider);
    return InAppWebView(
      initialUrlRequest:
          URLRequest(url: Uri.parse(qiitaAuth.getAuthorizeUrl(state))),
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      onLoadStart: (controller, url) async {
        debugPrint(url.toString());
        // webViewNotifier.loading();
        if (url != null) {
          try {
            await deleteCookies(url);
            if (url.toString().contains('/oauth/callback')) {
              await qiitaAuth.login(url, state);
              webViewNotifier.hide();
              ref.invalidate(qiitaAuthStorageProvider);
            }
          } catch (e) {
            debugPrint(e.toString());
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
        /*
        issue:
        we want to allow redirect to qiita://oauth/callback
        but onLoadError is called when redirected to cusotom url schemes.
        */
        // webViewNotifier.loaded();
      },
    );
  }
}
