import '../entities/coin_detail.dart';
import '../repositories/coin_detail_repository.dart';

class GetCoinDetailUseCase {
  final CoinDetailRepository repository;

  const GetCoinDetailUseCase(this.repository);

  Future<CoinDetail> call({
    required String coinId,
    required String currencyCode,
    required bool forceRefresh,
  }) {
    return repository.getCoinDetail(
      coinId: coinId,
      currencyCode: currencyCode,
      forceRefresh: forceRefresh,
    );
  }
}
