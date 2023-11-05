// File: my_page.dart
import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/api/qiita_auth.dart';
import 'package:qiita_trend/constant/default_values.dart';
import 'package:qiita_trend/constant/url.dart';
import 'package:qiita_trend/provider/qiita_auth_provider.dart';
import 'package:uuid/uuid.dart';
import '/pages/qiita_profile/provider/qiita_profile_provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class QiitaProfilePage extends ConsumerStatefulWidget {
  const QiitaProfilePage({super.key});
  @override
  QiitaProfilePageState createState() => QiitaProfilePageState();
}

class QiitaProfilePageState extends ConsumerState<QiitaProfilePage> {
  late StreamSubscription<Uri?> _subscription;
  final qiitaAuth = QiitaAuth();

  InAppWebViewController? webViewController;
  CookieManager cookieManager = CookieManager.instance();
  @override
  void initState() {
    super.initState();
    _subscription = uriLinkStream.listen((Uri? uri) {
      if (uri != null && uri.toString().contains('/oauth/callback')) {
        qiitaAuth.login(uri);
      } else {
        debugPrint('wrong url');
        debugPrint(uri.toString());
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final qiitaProfileAsync = ref.watch(qiitaProfileProvider);
    final isQiitaAuthAsync = ref.watch(qiitaAuthProvider);
    final String clientId = dotenv.env['QIITA_CLIENT_ID']!;
    final String state = const Uuid().v4();
    const String scope = QIITA_SCOPE;
    final url = Uri.https(QIITA_BASE_URL, QIITA_API_V2_AUTHORIZE, {
      'client_id': clientId,
      'scope': scope,
      'state': state,
      'response_type': 'code',
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Proflie"),
      ),
      body: isQiitaAuthAsync.when(
        error: (e, s) => Text(e.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (isAuth) {
          return Scaffold(
              body: Column(children: [
            isAuth
                ? qiitaProfileAsync.when(
                    error: (e, s) => Text(e.toString()),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    data: (qiitProfile) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('userame: ${qiitProfile.name ?? '名無し'} さん'),
                            ElevatedButton(
                                onPressed: () => {
                                      qiitaAuth.logout(),
                                    },
                                child: const Text('ログアウト'))
                          ]);
                    },
                  )
                : Expanded(
                    child: InAppWebView(
                      initialUrlRequest:
                          URLRequest(url: Uri.parse(url.toString())),
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                      },
                      onLoadStart: (controller, url) async {
                        if (url != null &&
                            url.toString().contains('/oauth/callback')) {
                          await qiitaAuth.login(url);
                        } else {
                          debugPrint('wrong url');
                          debugPrint(url.toString());
                        }
                        deleteCookies(url);
                      },
                    ),
                  ),
          ]));
        },
      ),
    );
  }
}

Future<List<Cookie>> test(Uri url, CookieManager cookieManager) async {
  List<Cookie> cookies = await cookieManager.getCookies(url: url);

  return cookies;
}

Future<void> deleteCookies(Uri? uri) async {
  final url = Uri.parse(uri.toString()); // Replace with your actual URL
  var cookieManager = CookieManager.instance();

  // Retrieve all cookies
  List<Cookie> cookies = await cookieManager.getCookies(url: url);

  // Print the cookies
  print('Cookies before deletion:');
  for (var cookie in cookies) {
    print(cookie);
  }

  // Delete all cookies for the domain
  for (var cookie in cookies) {
    await cookieManager.deleteCookie(
      url: url,
      name: cookie.name,
      domain: cookie.domain,
      path: cookie.path!,
    );
  }

  // Optionally, verify deletion by fetching cookies again
  List<Cookie> cookiesAfterDeletion = await cookieManager.getCookies(url: url);

  // Print the cookies after deletion attempt
  print('Cookies after deletion:');
  for (var cookie in cookiesAfterDeletion) {
    print(cookie);
  }
}
