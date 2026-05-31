import 'package:equatable/equatable.dart';

class MarketCoin extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final num currentPrice;
  final num marketCap;
  final int marketCapRank;
  final num priceChangePercentage24h;
  final List<double> sparklinePrices;

  const MarketCoin({
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

  @override
  List<Object?> get props {
    return [
      id,
      symbol,
      name,
      image,
      currentPrice,
      marketCap,
      marketCapRank,
      priceChangePercentage24h,
      sparklinePrices,
    ];
  }
}
