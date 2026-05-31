import '../entities/coin_detail.dart';
import '../entities/coin_price_point.dart';

abstract class CoinDetailRepository {
  Future<CoinDetail> getCoinDetail({
    required String coinId,
    required String currencyCode,
    required bool forceRefresh,
  });

  Future<List<CoinPricePoint>> getCoinMarketChart({
    required String coinId,
    required String currencyCode,
    required String days,
    required bool forceRefresh,
  });
}
