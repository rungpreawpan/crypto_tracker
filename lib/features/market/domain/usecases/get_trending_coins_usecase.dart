import '../entities/trending_coin.dart';
import '../repositories/market_repository.dart';

class GetTrendingCoinsUseCase {
  final MarketRepository repository;

  const GetTrendingCoinsUseCase(this.repository);

  Future<List<TrendingCoin>> call({required bool forceRefresh}) {
    return repository.getTrendingCoins(forceRefresh: forceRefresh);
  }
}
