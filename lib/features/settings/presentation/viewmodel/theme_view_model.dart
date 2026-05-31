import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_theme_mode.dart';
import '../providers/theme_providers.dart';

class ThemeViewModel extends Notifier<AppThemeMode> {
  @override
  AppThemeMode build() {
    return ref.read(getThemeModeUseCaseProvider).call();
  }

  Future<void> updateThemeMode(AppThemeMode mode) async {
    state = mode;
    await ref.read(saveThemeModeUseCaseProvider).call(mode);
  }
}
