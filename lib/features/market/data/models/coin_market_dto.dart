import '../../../../core/utils/json_reader.dart';

class CoinMarketDto {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final num currentPrice;
  final num marketCap;
  final int marketCapRank;
  final num priceChangePercentage24h;
  final List<double> sparklinePrices;

  const CoinMarketDto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.priceChangePercentage24h,
    required this.sparklinePrices,
  });

  factory CoinMarketDto.fromJson(Map<String, dynamic> json) {
    final sparkline = JsonReader.mapValue(json, 'sparkline_in_7d');
    final prices = sparkline['price'];

    return CoinMarketDto(
      id: JsonReader.stringValue(json, 'id'),
      symbol: JsonReader.stringValue(json, 'symbol'),
      name: JsonReader.stringValue(json, 'name'),
      image: JsonReader.stringValue(json, 'image'),
      currentPrice: JsonReader.numValue(json, 'current_price'),
      marketCap: JsonReader.numValue(json, 'market_cap'),
      marketCapRank: JsonReader.intValue(json, 'market_cap_rank'),
      priceChangePercentage24h: JsonReader.numValue(
        json,
        'price_change_percentage_24h',
      ),
      sparklinePrices: prices is List
          ? prices.map((item) {
              return (item as num).toDouble();
            }).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image,
      'current_price': currentPrice,
      'market_cap': marketCap,
      'market_cap_rank': marketCapRank,
      'price_change_percentage_24h': priceChangePercentage24h,
      'sparkline_in_7d': {'price': sparklinePrices},
    };
  }
}
