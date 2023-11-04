import 'package:flutter/foundation.dart';
import 'package:auto_route/auto_route.dart';
import '/ranking/view/page/ranking_page.dart';
import '/qiita_auth/view/page/login_page.dart';
import '/qiita_auth/view/page/settings_page.dart';
import '/ranking/model/tag_info.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: RankingRoute.page),
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: SettingsRoute.page),
      ];
}
