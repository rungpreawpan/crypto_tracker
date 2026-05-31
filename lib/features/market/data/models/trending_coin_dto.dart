import '../../../../core/utils/json_reader.dart';

class TrendingCoinDto {
  final String id;
  final String name;
  final String symbol;
  final String image;
  final int marketCapRank;
  final num price;
  final num priceChangePercentage24h;

  const TrendingCoinDto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.marketCapRank,
    required this.price,
    required this.priceChangePercentage24h,
  });

  factory TrendingCoinDto.fromJson(Map<String, dynamic> json) {
    final item = JsonReader.mapValue(json, 'item');
    final data = JsonReader.mapValue(item, 'data');
    final priceChange = JsonReader.mapValue(
      data,
      'price_change_percentage_24h',
    );

    return TrendingCoinDto(
      id: JsonReader.stringValue(item, 'id'),
      name: JsonReader.stringValue(item, 'name'),
      symbol: JsonReader.stringValue(item, 'symbol'),
      image: JsonReader.stringValue(item, 'small'),
      marketCapRank: JsonReader.intValue(item, 'market_cap_rank'),
      price: JsonReader.numValue(data, 'price'),
      priceChangePercentage24h: JsonReader.numValue(priceChange, 'usd'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': {
        'id': id,
        'name': name,
        'symbol': symbol,
        'small': image,
        'market_cap_rank': marketCapRank,
        'data': {
          'price': price,
          'price_change_percentage_24h': {'usd': priceChangePercentage24h},
        },
      },
    };
  }
}
