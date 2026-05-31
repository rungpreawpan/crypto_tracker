import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_currency.dart';
import '../providers/currency_providers.dart';

class CurrencyViewModel extends Notifier<AppCurrency> {
  @override
  AppCurrency build() {
    return ref.read(getCurrencyUseCaseProvider).call();
  }

  Future<void> updateCurrency(AppCurrency currency) async {
    state = currency;
    await ref.read(saveCurrencyUseCaseProvider).call(currency);
  }
}
