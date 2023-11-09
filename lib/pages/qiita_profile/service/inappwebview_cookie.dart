import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<List<Cookie>> getCookies(Uri uri) async {
  try {
    var cookieManager = CookieManager.instance();
    List<Cookie> cookies = await cookieManager.getCookies(url: uri);
    return cookies;
  } catch (e) {
    throw Exception(e);
  }
}

Future<void> deleteCookies(Uri uri) async {
  try {
    var cookieManager = CookieManager.instance();
    List<Cookie> cookies = await getCookies(uri);
    for (var cookie in cookies) {
      debugPrint(cookie.name);
    }
    cookieManager.deleteAllCookies();
    debugPrint('deleted');
    List<Cookie> deletedcookies = await getCookies(uri);
    for (var cookie in deletedcookies) {
      debugPrint(cookie.name);
    }
    for (var cookie in cookies) {
      if (cookie.name != 'secure_token' || cookie.name != 'user_session_key') {
        cookieManager.setCookie(
            url: uri, name: cookie.name, value: cookie.value);
      }
      // if (cookie.name == '_qiita_login_session') {
      //   continue;
      // }
      // if (cookie.path == null) {
      //   continue;
      // }
      // await cookieManager.deleteCookie(
      //   url: uri,
      //   name: cookie.name,
      //   domain: cookie.domain,
      //   path: cookie.path!,
      // );
    }
    debugPrint('set');
    List<Cookie> setcookies = await getCookies(uri);
    for (var cookie in setcookies) {
      debugPrint(cookie.name);
    }
  } catch (e) {
    throw Exception(e);
  }
}
