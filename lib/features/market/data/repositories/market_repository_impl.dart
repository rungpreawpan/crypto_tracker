import '../../../../core/error/app_exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/global_market.dart';
import '../../domain/entities/market_coin.dart';
import '../../domain/entities/trending_coin.dart';
import '../../domain/repositories/market_repository.dart';
import '../datasources/market_local_data_source.dart';
import '../datasources/market_remote_data_source.dart';
import '../mappers/coin_market_mapper.dart';
import '../mappers/global_market_mapper.dart';
import '../mappers/trending_coin_mapper.dart';

class MarketRepositoryImpl implements MarketRepository {
  final MarketRemoteDataSource remoteDataSource;
  final MarketLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const MarketRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<MarketCoin>> getMarketCoins({
    required int page,
    required String currencyCode,
    required bool forceRefresh,
  }) async {
    final connected = await networkInfo.isConnected;

    if (connected || forceRefresh) {
      try {
        final remoteCoins = await remoteDataSource.getMarketCoins(
          page: page,
          currencyCode: currencyCode,
        );
        await localDataSource.saveMarketCoins(
          page: page,
          currencyCode: currencyCode,
          coins: remoteCoins,
        );
        return remoteCoins.map(CoinMarketMapper.toEntity).toList();
      } catch (_) {
        return getCachedMarketCoins(page, currencyCode);
      }
    }

    return getCachedMarketCoins(page, currencyCode);
  }

  @override
  Future<GlobalMarket> getGlobalMarket({
    required String currencyCode,
    required bool forceRefresh,
  }) async {
    final connected = await networkInfo.isConnected;

    if (connected || forceRefresh) {
      try {
        final remoteMarket = await remoteDataSource.getGlobalMarket();
        await localDataSource.saveGlobalMarket(remoteMarket);
        return GlobalMarketMapper.toEntity(remoteMarket, currencyCode);
      } catch (_) {
        return getCachedGlobalMarket(currencyCode);
      }
    }

    return getCachedGlobalMarket(currencyCode);
  }

  @override
  Future<List<TrendingCoin>> getTrendingCoins({
    required bool forceRefresh,
  }) async {
    final connected = await networkInfo.isConnected;

    if (connected || forceRefresh) {
      try {
        final remoteCoins = await remoteDataSource.getTrendingCoins();
        await localDataSource.saveTrendingCoins(remoteCoins);
        return remoteCoins.map(TrendingCoinMapper.toEntity).toList();
      } catch (_) {
        return getCachedTrendingCoins();
      }
    }

    return getCachedTrendingCoins();
  }

  List<MarketCoin> getCachedMarketCoins(int page, String currencyCode) {
    final cachedCoins = localDataSource.getMarketCoins(
      page: page,
      currencyCode: currencyCode,
    );

    if (cachedCoins.isEmpty) {
      throw const AppException('errors.market_cache_unavailable');
    }

    return cachedCoins.map(CoinMarketMapper.toEntity).toList();
  }

  GlobalMarket getCachedGlobalMarket(String currencyCode) {
    final cachedMarket = localDataSource.getGlobalMarket();

    if (cachedMarket == null) {
      throw const AppException('errors.global_market_cache_unavailable');
    }

    return GlobalMarketMapper.toEntity(cachedMarket, currencyCode);
  }

  List<TrendingCoin> getCachedTrendingCoins() {
    final cachedCoins = localDataSource.getTrendingCoins();

    if (cachedCoins.isEmpty) {
      throw const AppException('errors.trending_cache_unavailable');
    }

    return cachedCoins.map(TrendingCoinMapper.toEntity).toList();
  }
}
