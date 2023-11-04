import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/constant/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QiitaAuthRepository {
  final String clientId;
  final String clientSecret;
  final String state;
  final String scope = 'read_qiita write_qiita';

  QiitaAuthRepository(this.clientId, this.clientSecret, this.state);

  Future<String> authorize() async {
    final url = Uri.https(QIITA_BASE_URL, QIITA_API_V2_AUTHORIZE, {
      'client_id': clientId,
      'scope': scope,
      'state': state,
    });

    final result = await FlutterWebAuth2.authenticate(
        url: url.toString(), callbackUrlScheme: 'qiita_trend://oauth/callback');

    final authorizationCode = Uri.parse(result).queryParameters['code'];
    if (authorizationCode != null) {
      return await _getAccessToken(authorizationCode);
    } else {
      throw Exception('Authorization failed');
    }
  }

  Future<String> _getAccessToken(String authorizationCode) async {
    const url = '$QIITA_BASE_URL$QIITA_API_V2_ACCESS_TOKEN';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': authorizationCode,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['token'];
    } else {
      throw Exception('Failed to get access token: ${response.body}');
    }
  }

  Future<void> invalidateAccessToken(String accessToken) async {
    final url = '$QIITA_BASE_URL$QIITA_API_V2_ACCESS_TOKEN/$accessToken';
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to invalidate access token: ${response.body}');
    }
  }
}
