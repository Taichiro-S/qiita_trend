import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qiita_trend/constant/storage_key.dart';
import 'package:qiita_trend/pages/qiita_profile/model/qiita_tag.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/constant/url.dart';
import '/service/secure_storage.dart';

part 'qiita_following_tags_api.g.dart';

class QiitaFollowingTagsApi {
  Future<List<QiitaTag>> fetchFollowingTags({required String userId}) async {
    try {
      final url =
          Uri.https(QIITA_BASE_URL, '/api/v2/users/$userId/following_tags');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        final result = data
            .map((e) => QiitaTag.fromJson(e as Map<String, dynamic>))
            .toList();
        return result;
      } else {
        throw Exception(
            'Failed to fecth following tags: ${response.body}; statusCode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get following tags: $e');
    }
  }

  Future<List<QiitaTag>> followTag(
      {required String userId, required String tagId}) async {
    try {
      final secureStorage = SecureStorage();
      final accessToken = await secureStorage.read(QIITA_API_ACCESS_TOKEN);
      final url = Uri.https(QIITA_BASE_URL, '/api/v2/tags/$tagId/following');
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 204) {
        return await fetchFollowingTags(userId: userId);
      } else {
        throw Exception(
            'Failed to fecth following tags: ${response.body}; statusCode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get following tags: $e');
    }
  }

  Future<List<QiitaTag>> unfollowTag(
      {required String userId, required String tagId}) async {
    try {
      final secureStorage = SecureStorage();
      final accessToken = await secureStorage.read(QIITA_API_ACCESS_TOKEN);
      final url = Uri.https(QIITA_BASE_URL, '/api/v2/tags/$tagId/following');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 204) {
        return await fetchFollowingTags(userId: userId);
      } else {
        throw Exception(
            'Failed to fecth following tags: ${response.body}; statusCode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get following tags: $e');
    }
  }
}

@riverpod
QiitaFollowingTagsApi qiitaFollowingTagsApi(QiitaFollowingTagsApiRef ref) {
  return QiitaFollowingTagsApi();
}
