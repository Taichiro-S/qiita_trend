import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<List<Cookie>> getCookies(Uri uri) async {
  var cookieManager = CookieManager.instance();
  List<Cookie> cookies = await cookieManager.getCookies(url: uri);
  return cookies;
}

Future<void> deleteCookies(Uri uri) async {
  var cookieManager = CookieManager.instance();
  List<Cookie> cookies = await getCookies(uri);

  // Delete all cookies for the domain
  for (var cookie in cookies) {
    await cookieManager.deleteCookie(
      url: uri,
      name: cookie.name,
      domain: cookie.domain,
      path: cookie.path!,
    );
  }
}
