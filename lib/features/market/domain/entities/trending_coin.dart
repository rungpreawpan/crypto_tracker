import 'package:equatable/equatable.dart';

class TrendingCoin extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final String image;
  final int marketCapRank;
  final num price;
  final num priceChangePercentage24h;

  const TrendingCoin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.marketCapRank,
    required this.price,
    required this.priceChangePercentage24h,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      symbol,
      image,
      marketCapRank,
      price,
      priceChangePercentage24h,
    ];
  }
}
