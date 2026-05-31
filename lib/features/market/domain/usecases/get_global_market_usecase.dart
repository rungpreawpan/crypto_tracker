import '../entities/global_market.dart';
import '../repositories/market_repository.dart';

class GetGlobalMarketUseCase {
  final MarketRepository repository;

  const GetGlobalMarketUseCase(this.repository);

  Future<GlobalMarket> call({
    required String currencyCode,
    required bool forceRefresh,
  }) {
    return repository.getGlobalMarket(
      currencyCode: currencyCode,
      forceRefresh: forceRefresh,
    );
  }
}
