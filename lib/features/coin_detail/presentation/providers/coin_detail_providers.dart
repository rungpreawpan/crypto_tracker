import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../../market/presentation/providers/market_providers.dart';
import '../../data/datasources/coin_detail_local_data_source.dart';
import '../../data/datasources/coin_detail_remote_data_source.dart';
import '../../data/repositories/coin_detail_repository_impl.dart';
import '../../domain/entities/coin_price_point.dart';
import '../../domain/repositories/coin_detail_repository.dart';
import '../../domain/usecases/get_coin_market_chart_usecase.dart';
import '../../domain/usecases/get_coin_detail_usecase.dart';
import '../state/coin_chart_range.dart';
import '../state/coin_detail_state.dart';
import '../viewmodel/coin_chart_range_view_model.dart';
import '../viewmodel/coin_chart_view_model.dart';
import '../viewmodel/coin_detail_view_model.dart';

final coinDetailRemoteDataSourceProvider = Provider<CoinDetailRemoteDataSource>(
  (ref) {
    return CoinDetailRemoteDataSource(ref.watch(coinGeckoApiProvider));
  },
);

final coinDetailLocalDataSourceProvider = Provider<CoinDetailLocalDataSource>((
  ref,
) {
  return CoinDetailLocalDataSource(ref.watch(coinDetailCacheBoxProvider));
});

final coinDetailRepositoryProvider = Provider<CoinDetailRepository>((ref) {
  return CoinDetailRepositoryImpl(
    remoteDataSource: ref.watch(coinDetailRemoteDataSourceProvider),
    localDataSource: ref.watch(coinDetailLocalDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

final getCoinDetailUseCaseProvider = Provider<GetCoinDetailUseCase>((ref) {
  return GetCoinDetailUseCase(ref.watch(coinDetailRepositoryProvider));
});

final getCoinMarketChartUseCaseProvider = Provider<GetCoinMarketChartUseCase>((
  ref,
) {
  return GetCoinMarketChartUseCase(ref.watch(coinDetailRepositoryProvider));
});

final coinChartRangeProvider =
    NotifierProvider.family<CoinChartRangeViewModel, CoinChartRange, String>((
      coinId,
    ) {
      return CoinChartRangeViewModel();
    });

final coinChartViewModelProvider =
    AsyncNotifierProvider.family<
      CoinChartViewModel,
      List<CoinPricePoint>,
      String
    >((coinId) {
      return CoinChartViewModel(coinId);
    });

final coinDetailViewModelProvider =
    AsyncNotifierProvider.family<CoinDetailViewModel, CoinDetailState, String>((
      coinId,
    ) {
      return CoinDetailViewModel(coinId);
    });
