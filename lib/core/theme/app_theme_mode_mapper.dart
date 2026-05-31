import 'package:flutter/material.dart';

import '../../features/settings/domain/entities/app_theme_mode.dart';

class AppThemeModeMapper {
  const AppThemeModeMapper._();

  static ThemeMode toFlutterThemeMode(AppThemeMode mode) {
    if (mode == AppThemeMode.light) {
      return ThemeMode.light;
    }

    if (mode == AppThemeMode.dark) {
      return ThemeMode.dark;
    }

    return ThemeMode.system;
  }
}
