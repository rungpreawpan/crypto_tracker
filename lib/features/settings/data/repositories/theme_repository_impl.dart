import '../../domain/entities/app_theme_mode.dart';
import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_data_source.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  const ThemeRepositoryImpl(this.localDataSource);

  @override
  AppThemeMode getThemeMode() {
    final modeName = localDataSource.getThemeModeName();

    if (modeName == AppThemeMode.light.name) {
      return AppThemeMode.light;
    }

    if (modeName == AppThemeMode.dark.name) {
      return AppThemeMode.dark;
    }

    return AppThemeMode.system;
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) {
    return localDataSource.saveThemeModeName(mode.name);
  }
}
