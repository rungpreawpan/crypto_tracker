import '../../domain/entities/global_market.dart';
import '../models/global_market_dto.dart';

class GlobalMarketMapper {
  const GlobalMarketMapper._();

  static GlobalMarket toEntity(GlobalMarketDto dto, String currencyCode) {
    return GlobalMarket(
      activeCryptocurrencies: dto.activeCryptocurrencies,
      markets: dto.markets,
      totalMarketCapUsd: dto.totalMarketCapForCurrency(currencyCode),
      totalVolumeUsd: dto.totalVolumeForCurrency(currencyCode),
      btcMarketCapPercentage: dto.marketCapPercentageForCoin('btc'),
      marketCapChangePercentage24hUsd: dto.marketCapChangePercentage24hUsd,
    );
  }
}
