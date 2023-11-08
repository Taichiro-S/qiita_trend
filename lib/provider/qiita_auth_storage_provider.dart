import 'package:qiita_trend/service/secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/constant/storage_key.dart';

part 'qiita_auth_storage_provider.g.dart';

@riverpod
// Future<bool> qiitaAuth(QiitaAuthRef ref) async {
//   final secureStorage = SecureStorage();
//   try {
//     if (await secureStorage.get(QIITA_API_ACCESS_TOKEN) != null) {
//       return true;
//     }
//     return false;
//   } catch (e) {
//     throw Exception('Flutter Storage error: $e');
//   }
// }

class QiitaAuthStorage extends _$QiitaAuthStorage {
  final secureStorage = SecureStorage();
  @override
  Future<bool> build() async {
    try {
      if (await secureStorage.read(QIITA_API_ACCESS_TOKEN) != null) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Flutter Storage error: $e');
    }
  }
}
