import 'package:auto_route/auto_route.dart';

import '/pages/qiita_profile/qiita_profile_page.dart';
import '/pages/ranking/ranking_page.dart';
import '../pages/display_settings/display_settings_page.dart';
import '/root_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: RootRoute.page, children: [
          AutoRoute(path: '', page: RankingRoute.page),
          AutoRoute(path: 'qiita_profile', page: QiitaProfileRoute.page),
        ]),
        AutoRoute(path: '/display_settings', page: DisplaySettingsRoute.page),
      ];
}
