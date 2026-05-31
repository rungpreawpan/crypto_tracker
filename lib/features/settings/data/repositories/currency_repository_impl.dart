import '../../domain/entities/app_currency.dart';
import '../../domain/repositories/currency_repository.dart';
import '../datasources/currency_local_data_source.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyLocalDataSource localDataSource;

  const CurrencyRepositoryImpl(this.localDataSource);

  @override
  AppCurrency getCurrency() {
    final currencyName = localDataSource.getCurrencyName();

    if (currencyName == AppCurrency.thb.name) {
      return AppCurrency.thb;
    }

    if (currencyName == AppCurrency.eur.name) {
      return AppCurrency.eur;
    }

    return AppCurrency.usd;
  }

  @override
  Future<void> saveCurrency(AppCurrency currency) {
    return localDataSource.saveCurrencyName(currency.name);
  }
}
