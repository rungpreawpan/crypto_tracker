import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../data/datasources/currency_local_data_source.dart';
import '../../data/repositories/currency_repository_impl.dart';
import '../../domain/entities/app_currency.dart';
import '../../domain/repositories/currency_repository.dart';
import '../../domain/usecases/get_currency_usecase.dart';
import '../../domain/usecases/save_currency_usecase.dart';
import '../viewmodel/currency_view_model.dart';

final currencyLocalDataSourceProvider = Provider<CurrencyLocalDataSource>((
  ref,
) {
  return CurrencyLocalDataSource(ref.watch(settingsBoxProvider));
});

final currencyRepositoryProvider = Provider<CurrencyRepository>((ref) {
  return CurrencyRepositoryImpl(ref.watch(currencyLocalDataSourceProvider));
});

final getCurrencyUseCaseProvider = Provider<GetCurrencyUseCase>((ref) {
  return GetCurrencyUseCase(ref.watch(currencyRepositoryProvider));
});

final saveCurrencyUseCaseProvider = Provider<SaveCurrencyUseCase>((ref) {
  return SaveCurrencyUseCase(ref.watch(currencyRepositoryProvider));
});

final appCurrencyProvider = NotifierProvider<CurrencyViewModel, AppCurrency>(
  () {
    return CurrencyViewModel();
  },
);
