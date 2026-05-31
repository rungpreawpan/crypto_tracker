import '../../domain/entities/market_coin.dart';
import '../models/coin_market_dto.dart';

class CoinMarketMapper {
  const CoinMarketMapper._();

  static MarketCoin toEntity(CoinMarketDto dto) {
    return MarketCoin(
      id: dto.id,
      symbol: dto.symbol,
      name: dto.name,
      image: dto.image,
      currentPrice: dto.currentPrice,
      marketCap: dto.marketCap,
      marketCapRank: dto.marketCapRank,
      priceChangePercentage24h: dto.priceChangePercentage24h,
      sparklinePrices: dto.sparklinePrices,
    );
  }
}
