import '../../domain/entities/coin_detail.dart';
import '../models/coin_detail_dto.dart';

class CoinDetailMapper {
  const CoinDetailMapper._();

  static CoinDetail toEntity(CoinDetailDto dto, String currencyCode) {
    return CoinDetail(
      id: dto.id,
      symbol: dto.symbol,
      name: dto.name,
      image: dto.image,
      description: dto.description,
      marketCapRank: dto.marketCapRank,
      currentPrice: dto.currentPriceForCurrency(currencyCode),
      marketCap: dto.marketCapForCurrency(currencyCode),
      totalVolume: dto.totalVolumeForCurrency(currencyCode),
      ath: dto.athForCurrency(currencyCode),
      circulatingSupply: dto.circulatingSupply,
      totalSupply: dto.totalSupply,
      maxSupply: dto.maxSupply,
      priceChangePercentage24h: dto.priceChangePercentage24h,
    );
  }
}
