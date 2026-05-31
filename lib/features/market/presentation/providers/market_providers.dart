import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/network/coingecko_api.dart';
import '../../data/datasources/market_local_data_source.dart';
import '../../data/datasources/market_remote_data_source.dart';
import '../../data/repositories/market_repository_impl.dart';
import '../../domain/repositories/market_repository.dart';
import '../../domain/usecases/get_global_market_usecase.dart';
import '../../domain/usecases/get_market_coins_usecase.dart';
import '../../domain/usecases/get_trending_coins_usecase.dart';
import '../state/market_state.dart';
import '../viewmodel/market_view_model.dart';

final coinGeckoApiProvider = Provider<CoinGeckoApi>((ref) {
  return CoinGeckoApi(ref.watch(dioProvider));
});

final marketRemoteDataSourceProvider = Provider<MarketRemoteDataSource>((ref) {
  return MarketRemoteDataSource(ref.watch(coinGeckoApiProvider));
});

final marketLocalDataSourceProvider = Provider<MarketLocalDataSource>((ref) {
  return MarketLocalDataSource(ref.watch(marketCacheBoxProvider));
});

final marketRepositoryProvider = Provider<MarketRepository>((ref) {
  return MarketRepositoryImpl(
    remoteDataSource: ref.watch(marketRemoteDataSourceProvider),
    localDataSource: ref.watch(marketLocalDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

final getMarketCoinsUseCaseProvider = Provider<GetMarketCoinsUseCase>((ref) {
  return GetMarketCoinsUseCase(ref.watch(marketRepositoryProvider));
});

final getGlobalMarketUseCaseProvider = Provider<GetGlobalMarketUseCase>((ref) {
  return GetGlobalMarketUseCase(ref.watch(marketRepositoryProvider));
});

final getTrendingCoinsUseCaseProvider = Provider<GetTrendingCoinsUseCase>((
  ref,
) {
  return GetTrendingCoinsUseCase(ref.watch(marketRepositoryProvider));
});

final marketViewModelProvider =
    AsyncNotifierProvider<MarketViewModel, MarketState>(() {
      return MarketViewModel();
    });

final searchDebounceProvider = Provider<Duration>((ref) {
  return const Duration(milliseconds: 350);
});

final searchTimerProvider = Provider<Timer?>((ref) {
  return null;
});
