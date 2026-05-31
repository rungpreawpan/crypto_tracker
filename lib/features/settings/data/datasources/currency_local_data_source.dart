import 'package:hive/hive.dart';

import '../../../../core/constants/local_storage_keys.dart';

class CurrencyLocalDataSource {
  final Box<String> box;

  const CurrencyLocalDataSource(this.box);

  String getCurrencyName() {
    return box.get(LocalStorageKeys.appCurrency, defaultValue: 'usd') ?? 'usd';
  }

  Future<void> saveCurrencyName(String currencyName) {
    return box.put(LocalStorageKeys.appCurrency, currencyName);
  }
}
