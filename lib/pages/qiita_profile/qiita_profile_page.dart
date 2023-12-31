import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/api/qiita_auth_api.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/qiita_profile_provider.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/webview_provider.dart';
import 'package:qiita_trend/pages/qiita_profile/widget/qiita_login_page_widget.dart';
import 'package:qiita_trend/provider/qiita_auth_storage_provider.dart';
import 'package:qiita_trend/theme/app_colors.dart';
import 'package:qiita_trend/widget/circle_loading_widget.dart';

@RoutePage()
class QiitaProfilePage extends ConsumerWidget {
  const QiitaProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webView = ref.watch(webViewProvider);
    final webViewNotifier = ref.read(webViewProvider.notifier);
    final isQiitaAuthAsync = ref.watch(qiitaAuthStorageProvider);
    final qiitaAuth = QiitaAuthApi();

    ref.listen<AsyncValue<bool>>(qiitaAuthStorageProvider,
        (_, isQiitaAuthAsync) {
      if (isQiitaAuthAsync.value == true) {
        ref.invalidate(qiitaProfileProvider);
      }
    });
    if (webView.isOpen) {
      return Scaffold(
          appBar: AppBar(
              title: Row(children: [
            IconButton(
              icon: const Icon(Icons.close_outlined, color: Colors.black54),
              onPressed: () => webViewNotifier.hide(),
            ),
            const Padding(
                padding: EdgeInsetsDirectional.only(start: 20),
                child: Text("Login Qiita account")),
          ])),
          body: Column(children: [
            Expanded(
                child: Stack(children: <Widget>[
              const QiitaLoginPageWidget(),
              webView.isError
                  ? Container(
                      color: Colors.white,
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                            Text(webView.errorText,
                                style:
                                    TextStyle(color: AppColors.light().onError))
                          ])))
                  : webView.isLoading
                      ? Container(
                          color: Colors.white,
                          child: const Center(
                              child: CircleLoadingWidget(
                                  color: Colors.green, fontSize: 20)),
                        )
                      : Container()
            ]))
          ]));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Proflie"),
          ),
          body: isQiitaAuthAsync.when(
            error: (e, s) => Text(e.toString()),
            loading: () => const Center(
                child: CircleLoadingWidget(color: Colors.green, fontSize: 20)),
            data: (isAuth) {
              if (isAuth) {
                final qiitaProfileAsync = ref.watch(qiitaProfileProvider);
                return qiitaProfileAsync.when(
                  error: (e, s) => Text(e.toString()),
                  loading: () => const Center(
                      child: CircleLoadingWidget(
                          color: Colors.green, fontSize: 20)),
                  data: (qiitaProfile) {
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                          Text('userame: ${qiitaProfile.name ?? '名無し'} さん'),
                          ElevatedButton(
                              onPressed: () async {
                                await qiitaAuth.logout();
                                ref.invalidate(qiitaAuthStorageProvider);
                              },
                              child: const Text('ログアウト'))
                        ]));
                  },
                );
              } else {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      const Text('ログインしていません'),
                      ElevatedButton(
                          onPressed: () => webViewNotifier.show(),
                          child: const Text('ログイン'))
                    ]));
              }
            },
          ));
    }
  }
}
