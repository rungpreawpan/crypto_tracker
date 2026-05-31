import '../entities/app_theme_mode.dart';
import '../repositories/theme_repository.dart';

class GetThemeModeUseCase {
  final ThemeRepository repository;

  const GetThemeModeUseCase(this.repository);

  AppThemeMode call() {
    return repository.getThemeMode();
  }
}
