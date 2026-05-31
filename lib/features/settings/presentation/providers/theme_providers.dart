import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../data/datasources/theme_local_data_source.dart';
import '../../data/repositories/theme_repository_impl.dart';
import '../../domain/entities/app_theme_mode.dart';
import '../../domain/repositories/theme_repository.dart';
import '../../domain/usecases/get_theme_mode_usecase.dart';
import '../../domain/usecases/save_theme_mode_usecase.dart';
import '../viewmodel/theme_view_model.dart';

final themeLocalDataSourceProvider = Provider<ThemeLocalDataSource>((ref) {
  return ThemeLocalDataSource(ref.watch(settingsBoxProvider));
});

final themeRepositoryProvider = Provider<ThemeRepository>((ref) {
  return ThemeRepositoryImpl(ref.watch(themeLocalDataSourceProvider));
});

final getThemeModeUseCaseProvider = Provider<GetThemeModeUseCase>((ref) {
  return GetThemeModeUseCase(ref.watch(themeRepositoryProvider));
});

final saveThemeModeUseCaseProvider = Provider<SaveThemeModeUseCase>((ref) {
  return SaveThemeModeUseCase(ref.watch(themeRepositoryProvider));
});

final appThemeModeProvider = NotifierProvider<ThemeViewModel, AppThemeMode>(() {
  return ThemeViewModel();
});
