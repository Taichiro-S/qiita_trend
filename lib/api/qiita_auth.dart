import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:qiita_trend/constant/default_values.dart';
import '/constant/storage_key.dart';
import '/constant/url.dart';
import '/service/secure_storage.dart';

class QiitaAuth {
  final String clientId = dotenv.env['QIITA_CLIENT_ID']!;
  final String clientSecret = dotenv.env['QIITA_CLIENT_SECRET']!;
  final String scope = QIITA_SCOPE;
  final _secureStorage = SecureStorage();

  String getAuthorizeUrl(String state) {
    return Uri.https(QIITA_BASE_URL, QIITA_API_V2_AUTHORIZE, {
      'client_id': clientId,
      'scope': scope,
      'state': state,
      'response_type': 'code',
    }).toString();
  }

  Future<void> login(Uri uri, String state) async {
    final authorizationCode = Uri.parse(uri.toString()).queryParameters['code'];
    final callbackState = Uri.parse(uri.toString()).queryParameters['state'];
    if (authorizationCode != null && callbackState == state) {
      final accessToken = await _getAccessToken(authorizationCode);
      await _secureStorage.write(QIITA_API_ACCESS_TOKEN, accessToken);
    } else {
      throw Exception('Authorization failed');
    }
  }

  Future<String> _getAccessToken(String authorizationCode) async {
    final url = Uri.https(QIITA_BASE_URL, QIITA_API_V2_ACCESS_TOKEN).toString();
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

    if (response.statusCode == 201) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return data['token'].toString();
    } else {
      throw Exception('Failed to get access token: ${response.body}');
    }
  }

  Future<void> logout() async {
    final accessToken = await _secureStorage.read(QIITA_API_ACCESS_TOKEN);
    final url =
        Uri.https(QIITA_BASE_URL, '$QIITA_API_V2_ACCESS_TOKEN/$accessToken')
            .toString();
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    await _secureStorage.delete(QIITA_API_ACCESS_TOKEN);
    if (response.statusCode != 204) {
      throw Exception('Failed to invalidate access token: ${response.body}');
    }
  }
}
