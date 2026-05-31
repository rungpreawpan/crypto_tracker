import '../entities/market_coin.dart';
import '../repositories/market_repository.dart';

class GetMarketCoinsUseCase {
  final MarketRepository repository;

  const GetMarketCoinsUseCase(this.repository);

  Future<List<MarketCoin>> call({
    required int page,
    required String currencyCode,
    required bool forceRefresh,
  }) {
    return repository.getMarketCoins(
      page: page,
      currencyCode: currencyCode,
      forceRefresh: forceRefresh,
    );
  }
}
