import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/uuid_provider.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/webview_provider.dart';
import 'package:qiita_trend/provider/qiita_auth_storage_provider.dart';
import '/api/qiita_auth.dart';
import '../service/inappwebview_cookie_manager.dart';

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
      initialOptions: InAppWebViewGroupOptions(
          android: AndroidInAppWebViewOptions(
              initialScale: 100, disableDefaultErrorPage: true)),
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      onLoadStart: (controller, url) async {
        if (url != null) {
          webViewNotifier.loading();
          webViewNotifier.clearError();
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
        if (url.toString().startsWith('https://qiita.com/login')) {
          await controller.evaluateJavascript(source: """
        document.querySelector('.sessions-Registration_oauthWrapper').style.display = 'none';
        // Use the appropriate selector for the elements you want to hide or remove
      """);
        }
        webViewNotifier.loaded();
      },
      onLoadError: (controller, url, code, message) {
        // allow redirect to qiitatrend://oauth/callback
        if (url.toString().startsWith('qiitatrend') &&
            url.toString().contains('/oauth/callback')) {
          return;
        }
        debugPrint(message);
        webViewNotifier.error(message);
      },
    );
  }
}
