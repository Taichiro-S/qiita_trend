import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/pages/qiita_profile/api/qiita_profile.dart';
import '/pages/qiita_profile/model/qiita_profile.dart';

part 'qiita_profile_provider.g.dart';

@riverpod
Future<QiitaProfile> qiitaProfile(QiitaProfileRef ref) async {
  final api = QiitaProfileApi();
  return api.getProfile();
}
