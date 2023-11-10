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
    // because cookie.path on android is always null
    // we need to delete all cookies and set them again
    cookieManager.deleteAllCookies();
    for (var cookie in cookies) {
      if (cookie.name != 'secure_token' || cookie.name != 'user_session_key') {
        cookieManager.setCookie(
            url: uri, name: cookie.name, value: cookie.value);
      }
    }
  } catch (e) {
    throw Exception(e);
  }
}
