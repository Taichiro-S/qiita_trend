import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/api/qiita_auth.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/webview_provider.dart';
import 'package:qiita_trend/pages/qiita_profile/widget/qiita_login_page_widget.dart';
import 'package:qiita_trend/provider/qiita_auth_storage_provider.dart';
import '/pages/qiita_profile/provider/qiita_profile_provider.dart';

@RoutePage()
class QiitaProfilePage extends ConsumerWidget {
  const QiitaProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webView = ref.watch(webViewProvider);
    final webViewNotifier = ref.read(webViewProvider.notifier);
    final isQiitaAuthAsync = ref.watch(qiitaAuthStorageProvider);
    final qiitaAuth = QiitaAuth();

    ref.listen<AsyncValue<bool>>(qiitaAuthStorageProvider,
        (_, isQiitaAuthAsync) {
      if (isQiitaAuthAsync.value == true) {
        // If the user is authenticated, fetch the profile
        // ref.invalidate(qiitaProfileProvider);
      }
    });
    if (webView['open']!) {
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
          body:
              // webView['loading']!
              // ? const Center(child: CircularProgressIndicator())
              // :
              const Column(children: [
            Expanded(
                child: Stack(children: [
              QiitaLoginPageWidget(),
            ]))
          ]));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Proflie"),
          ),
          body: isQiitaAuthAsync.when(
            error: (e, s) => Text(e.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (isAuth) {
              // Only build the profile UI if the user is authenticated
              if (isAuth) {
                // Watch the profile provider here inside the condition
                final qiitaProfileAsync = ref.watch(qiitaProfileProvider);
                return qiitaProfileAsync.when(
                  error: (e, s) => Text(e.toString()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  data: (qiitaProfile) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('userame: ${qiitaProfile.name ?? '名無し'} さん'),
                          ElevatedButton(
                              onPressed: () async {
                                await qiitaAuth.logout();
                                ref.invalidate(qiitaAuthStorageProvider);
                              },
                              child: const Text('ログアウト'))
                        ]);
                  },
                );
              } else {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('ログインしていません'),
                      ElevatedButton(
                          onPressed: () => webViewNotifier.show(),
                          child: const Text('ログイン'))
                    ]);
              }
            },
          ));
    }
  }
}

//         body: isQiitaAuthAsync.when(
//           error: (e, s) => Text(e.toString()),
//           loading: () => const Center(child: CircularProgressIndicator()),
//           data: (isAuth) {
//             return Scaffold(
//                 body: Column(children: [
//               isAuth
//                   ? qiitaProfileAsync.when(
//                       error: (e, s) => Text(e.toString()),
//                       loading: () =>
//                           const Center(child: CircularProgressIndicator()),
//                       data: (qiitaProfile) {
//                         return Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('userame: ${qiitaProfile.name ?? '名無し'} さん'),
//                               ElevatedButton(
//                                   onPressed: () async {
//                                     await qiitaAuth.logout();
//                                     ref.invalidate(qiitaAuthStorageProvider);
//                                   },
//                                   child: const Text('ログアウト'))
//                             ]);
//                       },
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                           const Text('ログインしていません'),
//                           ElevatedButton(
//                               onPressed: () => webViewNotifier.show(),
//                               child: const Text('ログイン'))
//                         ])
//             ]));
//           },
//         ),
//       );
//     }
//   }
// }
