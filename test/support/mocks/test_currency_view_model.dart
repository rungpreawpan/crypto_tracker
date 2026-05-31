import 'package:crypto_tracker/features/settings/domain/entities/app_currency.dart';
import 'package:crypto_tracker/features/settings/presentation/viewmodel/currency_view_model.dart';

class TestCurrencyViewModel extends CurrencyViewModel {
  @override
  AppCurrency build() {
    return AppCurrency.usd;
  }
}
