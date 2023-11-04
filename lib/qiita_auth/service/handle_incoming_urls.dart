// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:qiita_trend/qiita_auth/api/qiita_auth.dart';
// import 'package:uni_links/uni_links.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import '/routes/router.dart';

// Future<void> handleLink(Uri? link, AutoRouter router) async {
//   if (link == null) {
//     return;
//   }
//   var authCode = link.queryParameters['code'];
//   if (authCode != null) {
//     final qiitaAuthRepo = QiitaAuthRepository(
//       dotenv.env['QIITA_CLIENT_ID']!,
//       dotenv.env['QIITA_CLIENT_SECRET']!,
//       authCode,
//     );
//     final accessToken = await qiitaAuthRepo.authorize();
//     const storage = FlutterSecureStorage();
//     await storage.write(key: 'qiitaApiAccessToken', value: accessToken);
//   }
// }

// void handleIncomingLinks(AutoRouter router) async {
//   try {
//     Uri? initialLink = await getInitialUri();
//     if (initialLink != null) {
//       await handleLink(initialLink, router);
//     }
//     // Use uriLinkStream instead of getUriLinksStream
//     uriLinkStream.listen((Uri? uri) {
//       handleLink(uri, router);
//     }, onError: (err) {
//       // Handle exceptions (optional)
//     });
//   } catch (e) {
//     // Handle exceptions (optional)
//   }
// }
