import '../../domain/entities/trending_coin.dart';
import '../models/trending_coin_dto.dart';

class TrendingCoinMapper {
  const TrendingCoinMapper._();

  static TrendingCoin toEntity(TrendingCoinDto dto) {
    return TrendingCoin(
      id: dto.id,
      name: dto.name,
      symbol: dto.symbol,
      image: dto.image,
      marketCapRank: dto.marketCapRank,
      price: dto.price,
      priceChangePercentage24h: dto.priceChangePercentage24h,
    );
  }
}
