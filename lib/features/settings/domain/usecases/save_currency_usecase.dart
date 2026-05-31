import '../entities/app_currency.dart';
import '../repositories/currency_repository.dart';

class SaveCurrencyUseCase {
  final CurrencyRepository repository;

  const SaveCurrencyUseCase(this.repository);

  Future<void> call(AppCurrency currency) {
    return repository.saveCurrency(currency);
  }
}
