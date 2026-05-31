import 'package:equatable/equatable.dart';

class CoinDetail extends Equatable {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final String description;
  final int marketCapRank;
  final num currentPrice;
  final num marketCap;
  final num totalVolume;
  final num ath;
  final num circulatingSupply;
  final num totalSupply;
  final num maxSupply;
  final num priceChangePercentage24h;

  const CoinDetail({
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

  @override
  List<Object?> get props {
    return [
      id,
      symbol,
      name,
      image,
      description,
      marketCapRank,
      currentPrice,
      marketCap,
      totalVolume,
      ath,
      circulatingSupply,
      totalSupply,
      maxSupply,
      priceChangePercentage24h,
    ];
  }
}
