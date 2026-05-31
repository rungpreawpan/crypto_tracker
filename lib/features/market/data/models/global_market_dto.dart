import '../../../../core/utils/json_reader.dart';

class GlobalMarketDto {
  final num activeCryptocurrencies;
  final num markets;
  final Map<String, dynamic> totalMarketCap;
  final Map<String, dynamic> totalVolume;
  final Map<String, dynamic> marketCapPercentage;
  final num marketCapChangePercentage24hUsd;

  const GlobalMarketDto({
    required this.activeCryptocurrencies,
    required this.markets,
    required this.totalMarketCap,
    required this.totalVolume,
    required this.marketCapPercentage,
    required this.marketCapChangePercentage24hUsd,
  });

  factory GlobalMarketDto.fromJson(Map<String, dynamic> json) {
    final data = JsonReader.mapValue(json, 'data');
    final totalMarketCap = JsonReader.mapValue(data, 'total_market_cap');
    final totalVolume = JsonReader.mapValue(data, 'total_volume');
    final marketCapPercentage = JsonReader.mapValue(
      data,
      'market_cap_percentage',
    );

    return GlobalMarketDto(
      activeCryptocurrencies: JsonReader.numValue(
        data,
        'active_cryptocurrencies',
      ),
      markets: JsonReader.numValue(data, 'markets'),
      totalMarketCap: totalMarketCap,
      totalVolume: totalVolume,
      marketCapPercentage: marketCapPercentage,
      marketCapChangePercentage24hUsd: JsonReader.numValue(
        data,
        'market_cap_change_percentage_24h_usd',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'active_cryptocurrencies': activeCryptocurrencies,
        'markets': markets,
        'total_market_cap': totalMarketCap,
        'total_volume': totalVolume,
        'market_cap_percentage': marketCapPercentage,
        'market_cap_change_percentage_24h_usd': marketCapChangePercentage24hUsd,
      },
    };
  }

  num totalMarketCapForCurrency(String currencyCode) {
    return JsonReader.numValue(totalMarketCap, currencyCode);
  }

  num totalVolumeForCurrency(String currencyCode) {
    return JsonReader.numValue(totalVolume, currencyCode);
  }

  num marketCapPercentageForCoin(String coinSymbol) {
    return JsonReader.numValue(marketCapPercentage, coinSymbol.toLowerCase());
  }
}
