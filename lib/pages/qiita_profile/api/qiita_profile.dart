import '../model/qiita_profile.dart';
import '/constant/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/service/secure_storage.dart';

class QiitaProfileApi {
  final _secureStorage = SecureStorage();
  Future<QiitaProfile> getProfile() async {
    final accessToken = await _secureStorage.get('qiitaApiAccessToken');
    final url = Uri.https(QIITA_BASE_URL, QIITA_API_V2_AUTHENTICATED_USER);
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return QiitaProfile.fromJson(data);
    } else {
      throw Exception('Failed to get profile: ${response.body}');
    }
  }
}
