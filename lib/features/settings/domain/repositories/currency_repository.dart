import '../entities/app_currency.dart';

abstract class CurrencyRepository {
  AppCurrency getCurrency();

  Future<void> saveCurrency(AppCurrency currency);
}
