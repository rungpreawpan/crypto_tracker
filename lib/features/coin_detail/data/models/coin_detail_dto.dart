import '../../../../core/utils/json_reader.dart';

class CoinDetailDto {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final String description;
  final int marketCapRank;
  final Map<String, dynamic> currentPrice;
  final Map<String, dynamic> marketCap;
  final Map<String, dynamic> totalVolume;
  final Map<String, dynamic> ath;
  final num circulatingSupply;
  final num totalSupply;
  final num maxSupply;
  final num priceChangePercentage24h;

  const CoinDetailDto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.description,
    required this.marketCapRank,
    required this.currentPrice,
    required this.marketCap,
    required this.totalVolume,
    required this.ath,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.priceChangePercentage24h,
  });

  factory CoinDetailDto.fromJson(Map<String, dynamic> json) {
    final image = JsonReader.mapValue(json, 'image');
    final description = JsonReader.mapValue(json, 'description');
    final marketData = JsonReader.mapValue(json, 'market_data');
    final currentPrice = JsonReader.mapValue(marketData, 'current_price');
    final marketCap = JsonReader.mapValue(marketData, 'market_cap');
    final totalVolume = JsonReader.mapValue(marketData, 'total_volume');
    final ath = JsonReader.mapValue(marketData, 'ath');

    return CoinDetailDto(
      id: JsonReader.stringValue(json, 'id'),
      symbol: JsonReader.stringValue(json, 'symbol'),
      name: JsonReader.stringValue(json, 'name'),
      image: JsonReader.stringValue(image, 'large'),
      description: JsonReader.stringValue(description, 'en'),
      marketCapRank: JsonReader.intValue(json, 'market_cap_rank'),
      currentPrice: currentPrice,
      marketCap: marketCap,
      totalVolume: totalVolume,
      ath: ath,
      circulatingSupply: JsonReader.numValue(marketData, 'circulating_supply'),
      totalSupply: JsonReader.numValue(marketData, 'total_supply'),
      maxSupply: JsonReader.numValue(marketData, 'max_supply'),
      priceChangePercentage24h: JsonReader.numValue(
        marketData,
        'price_change_percentage_24h',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': {'large': image},
      'description': {'en': description},
      'market_cap_rank': marketCapRank,
      'market_data': {
        'current_price': currentPrice,
        'market_cap': marketCap,
        'total_volume': totalVolume,
        'ath': ath,
        'circulating_supply': circulatingSupply,
        'total_supply': totalSupply,
        'max_supply': maxSupply,
        'price_change_percentage_24h': priceChangePercentage24h,
      },
    };
  }

  num currentPriceForCurrency(String currencyCode) {
    return JsonReader.numValue(currentPrice, currencyCode);
  }

  num marketCapForCurrency(String currencyCode) {
    return JsonReader.numValue(marketCap, currencyCode);
  }

  num totalVolumeForCurrency(String currencyCode) {
    return JsonReader.numValue(totalVolume, currencyCode);
  }

  num athForCurrency(String currencyCode) {
    return JsonReader.numValue(ath, currencyCode);
  }
}
