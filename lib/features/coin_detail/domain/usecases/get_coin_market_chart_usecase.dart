import '../entities/coin_price_point.dart';
import '../repositories/coin_detail_repository.dart';

class GetCoinMarketChartUseCase {
  final CoinDetailRepository repository;

  const GetCoinMarketChartUseCase(this.repository);

  Future<List<CoinPricePoint>> call({
    required String coinId,
    required String currencyCode,
    required String days,
    required bool forceRefresh,
  }) {
    return repository.getCoinMarketChart(
      coinId: coinId,
      currencyCode: currencyCode,
      days: days,
      forceRefresh: forceRefresh,
    );
  }
}
