import '../entities/app_theme_mode.dart';
import '../repositories/theme_repository.dart';

class SaveThemeModeUseCase {
  final ThemeRepository repository;

  const SaveThemeModeUseCase(this.repository);

  Future<void> call(AppThemeMode mode) {
    return repository.saveThemeMode(mode);
  }
}
