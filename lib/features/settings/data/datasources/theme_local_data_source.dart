import 'package:hive/hive.dart';

import '../../../../core/constants/local_storage_keys.dart';

class ThemeLocalDataSource {
  final Box<String> box;

  const ThemeLocalDataSource(this.box);

  String getThemeModeName() {
    return box.get(LocalStorageKeys.appThemeMode, defaultValue: 'system') ??
        'system';
  }

  Future<void> saveThemeModeName(String modeName) {
    return box.put(LocalStorageKeys.appThemeMode, modeName);
  }
}
