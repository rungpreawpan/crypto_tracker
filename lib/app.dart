import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_mode_mapper.dart';
import 'features/settings/presentation/providers/theme_providers.dart';

class CryptoTrackerApp extends ConsumerWidget {
  const CryptoTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final appThemeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      title: 'CryptoTracker',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: AppThemeModeMapper.toFlutterThemeMode(appThemeMode),
      routerConfig: router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
    );
  }
}
