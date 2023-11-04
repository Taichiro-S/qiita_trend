import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/constant/url.dart';
import '/qiita_auth/provider/uuid_provider.dart';
part 'login_url_provider.g.dart';

@riverpod
Uri loginUrl(LoginUrlRef ref,
    {required String uuid, required String clientId, required String scope}) {
  final url = Uri.https(QIITA_BASE_URL, QIITA_API_V2_AUTHORIZE, {
    'client_id': clientId,
    'scope': scope,
    'state': uuid,
  });
  return url;
}
