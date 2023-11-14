import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/constant/url.dart';
import '/pages/qiita_profile/model/qiita_profile.dart';
import '/service/secure_storage.dart';

part 'qiita_profile_api.g.dart';

class QiitaProfileApi {
  Future<QiitaProfile> getProfile() async {
    try {
      final secureStorage = SecureStorage();
      final accessToken = await secureStorage.read('qiitaApiAccessToken');
      final url = Uri.https(QIITA_BASE_URL, QIITA_API_V2_AUTHENTICATED_USER);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        return QiitaProfile.fromJson(data);
      } else {
        throw Exception(
            'Failed to fecth profile: ${response.body}; statusCode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }
}

@riverpod
QiitaProfileApi qiitaProfileApi(QiitaProfileApiRef ref) {
  return QiitaProfileApi();
}
