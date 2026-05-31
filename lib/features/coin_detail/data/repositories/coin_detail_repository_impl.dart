import '../../../../core/error/app_exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/coin_detail.dart';
import '../../domain/entities/coin_price_point.dart';
import '../../domain/repositories/coin_detail_repository.dart';
import '../datasources/coin_detail_local_data_source.dart';
import '../datasources/coin_detail_remote_data_source.dart';
import '../mappers/coin_detail_mapper.dart';
import '../mappers/coin_market_chart_mapper.dart';

class CoinDetailRepositoryImpl implements CoinDetailRepository {
  final CoinDetailRemoteDataSource remoteDataSource;
  final CoinDetailLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const CoinDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<CoinDetail> getCoinDetail({
    required String coinId,
    required String currencyCode,
    required bool forceRefresh,
  }) async {
    final connected = await networkInfo.isConnected;

    if (connected || forceRefresh) {
      try {
        final remoteCoin = await remoteDataSource.getCoinDetail(coinId);
        await localDataSource.saveCoinDetail(remoteCoin);
        return CoinDetailMapper.toEntity(remoteCoin, currencyCode);
      } catch (_) {
        return getCachedCoinDetail(coinId, currencyCode);
      }
    }

    return getCachedCoinDetail(coinId, currencyCode);
  }

  CoinDetail getCachedCoinDetail(String coinId, String currencyCode) {
    final cachedCoin = localDataSource.getCoinDetail(coinId);

    if (cachedCoin == null) {
      throw const AppException('errors.coin_detail_cache_unavailable');
    }

    return CoinDetailMapper.toEntity(cachedCoin, currencyCode);
  }

  @override
  Future<List<CoinPricePoint>> getCoinMarketChart({
    required String coinId,
    required String currencyCode,
    required String days,
    required bool forceRefresh,
  }) async {
    final connected = await networkInfo.isConnected;

    if (connected || forceRefresh) {
      try {
        final remoteChart = await remoteDataSource.getCoinMarketChart(
          coinId: coinId,
          currencyCode: currencyCode,
          days: days,
        );
        await localDataSource.saveCoinMarketChart(
          coinId: coinId,
          currencyCode: currencyCode,
          days: days,
          chart: remoteChart,
        );
        return CoinMarketChartMapper.toEntity(remoteChart);
      } catch (_) {
        return getCachedCoinMarketChart(coinId, currencyCode, days);
      }
    }

    return getCachedCoinMarketChart(coinId, currencyCode, days);
  }

  List<CoinPricePoint> getCachedCoinMarketChart(
    String coinId,
    String currencyCode,
    String days,
  ) {
    final cachedChart = localDataSource.getCoinMarketChart(
      coinId: coinId,
      currencyCode: currencyCode,
      days: days,
    );

    if (cachedChart == null) {
      throw const AppException('errors.coin_chart_cache_unavailable');
    }

    return CoinMarketChartMapper.toEntity(cachedChart);
  }
}
