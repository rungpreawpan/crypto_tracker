import '../entities/app_currency.dart';
import '../repositories/currency_repository.dart';

class GetCurrencyUseCase {
  final CurrencyRepository repository;

  const GetCurrencyUseCase(this.repository);

  AppCurrency call() {
    return repository.getCurrency();
  }
}
