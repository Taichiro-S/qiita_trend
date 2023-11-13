import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qiita_trend/theme/app_theme.dart';
import 'package:sizer/sizer.dart';
import '/routes/router.dart';

Future<void> main() async {
  if (!kReleaseMode) {
    Fimber.plantTree(DebugTree());
  } else {
    debugPrint = (message, {wrapWidth}) {};
  }

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await dotenv.load(fileName: '.env');
      await Firebase.initializeApp();
      runApp(
        ProviderScope(
          child: DevicePreview(
            enabled: !kReleaseMode,
            builder: (context) => const MyApp(),
          ),
        ),
      );
    },
    (error, stackTrace) =>
        Fimber.e('runZonedGuarded', ex: error, stacktrace: stackTrace),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = useMemoized(() => AppRouter());
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    return Sizer(
        builder: ((context, orientation, deviceType) => MaterialApp.router(
              title: 'Qiita Trend',
              theme: theme.data,
              darkTheme: AppTheme.dark().data,
              themeMode: themeMode,
              routerConfig: appRouter.config(),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: L10n.localizationsDelegates,
              supportedLocales: L10n.supportedLocales,
              locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
            )));
  }
}
