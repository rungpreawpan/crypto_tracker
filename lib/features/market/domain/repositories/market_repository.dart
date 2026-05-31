import '../entities/global_market.dart';
import '../entities/market_coin.dart';
import '../entities/trending_coin.dart';

abstract class MarketRepository {
  Future<List<MarketCoin>> getMarketCoins({
    required int page,
    required String currencyCode,
    required bool forceRefresh,
  });

  Future<GlobalMarket> getGlobalMarket({
    required String currencyCode,
    required bool forceRefresh,
  });

  Future<List<TrendingCoin>> getTrendingCoins({required bool forceRefresh});
}
