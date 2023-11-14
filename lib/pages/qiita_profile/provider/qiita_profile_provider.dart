import 'package:qiita_trend/pages/qiita_profile/api/qiita_profile_api.dart';
import 'package:qiita_trend/pages/qiita_profile/model/qiita_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qiita_profile_provider.g.dart';

@riverpod
Future<QiitaProfile> qiitaProfile(QiitaProfileRef ref) async {
  final api = QiitaProfileApi();
  return api.getProfile();
}
