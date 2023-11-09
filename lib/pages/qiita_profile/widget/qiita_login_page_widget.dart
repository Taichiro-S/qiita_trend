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
    final webViewState = ref.watch(webViewProvider);
    final state = ref.read(uuidProvider);
    return InAppWebView(
      initialUrlRequest:
          URLRequest(url: Uri.parse(qiitaAuth.getAuthorizeUrl(state))),
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      onLoadStart: (controller, url) async {
        // debugPrint(url.toString());

        if (url != null) {
          webViewNotifier.loading();
          try {
            var cookies = await getCookies(url);
            for (var cookie in cookies) {
              debugPrint(cookie.toString());
            }
            await deleteCookies(url);
            cookies = await getCookies(url);
            debugPrint('cookies deleted');
            for (var cookie in cookies) {
              debugPrint(cookie.toString());
            }
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
        if (url.toString().startsWith('https://qiita.com/login')) {
          await controller.evaluateJavascript(source: """
        document.querySelector('.sessions-Registration_oauthWrapper').style.display = 'none';
        // Use the appropriate selector for the elements you want to hide or remove
      """);
        }
        webViewNotifier.loaded();
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
