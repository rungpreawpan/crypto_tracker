import 'package:crypto_tracker/features/market/domain/entities/global_market.dart';
import 'package:crypto_tracker/features/market/domain/entities/market_coin.dart';
import 'package:crypto_tracker/features/market/domain/entities/trending_coin.dart';
import 'package:crypto_tracker/features/market/domain/repositories/market_repository.dart';

class FakeMarketRepository implements MarketRepository {
  final GlobalMarket globalMarket;
  final List<TrendingCoin> trendingCoins;
  final Map<int, List<MarketCoin>> marketCoinsByPage;

  const FakeMarketRepository({
    required this.globalMarket,
    required this.trendingCoins,
    required this.marketCoinsByPage,
  });

  @override
  Future<GlobalMarket> getGlobalMarket({
    required String currencyCode,
    required bool forceRefresh,
  }) async {
    return globalMarket;
  }

  @override
  Future<List<MarketCoin>> getMarketCoins({
    required int page,
    required String currencyCode,
    required bool forceRefresh,
  }) async {
    return marketCoinsByPage[page] ?? [];
  }

  @override
  Future<List<TrendingCoin>> getTrendingCoins({
    required bool forceRefresh,
  }) async {
    return trendingCoins;
  }
}
