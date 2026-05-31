import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/constants/local_storage_keys.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<Map>(LocalStorageKeys.marketCacheBox);
  await Hive.openBox<Map>(LocalStorageKeys.coinDetailCacheBox);
  await Hive.openBox<String>(LocalStorageKeys.favoriteCoinBox);
  await Hive.openBox<String>(LocalStorageKeys.settingsBox);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('th')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const ProviderScope(child: CryptoTrackerApp()),
    ),
  );
}
