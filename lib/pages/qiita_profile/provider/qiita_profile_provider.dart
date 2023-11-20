import 'package:qiita_trend/pages/qiita_profile/api/qiita_profile_api.dart';
import 'package:qiita_trend/pages/qiita_profile/model/qiita_profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'qiita_profile_provider.g.dart';

@riverpod
class QiitaProfile extends _$QiitaProfile {
  @override
  QiitaProfileState build() {
    return const QiitaProfileState(
      qiitaProfile: AsyncValue.loading(),
    );
  }

  Future<void> getProfile() async {
    final api = QiitaProfileApi();
    final profile = await api.fetchProfile();
    state = state.copyWith(
      qiitaProfile: AsyncValue.data(profile),
    );
  }
}
