import 'package:equatable/equatable.dart';

class GlobalMarket extends Equatable {
  final num activeCryptocurrencies;
  final num markets;
  final num totalMarketCapUsd;
  final num totalVolumeUsd;
  final num btcMarketCapPercentage;
  final num marketCapChangePercentage24hUsd;

  const GlobalMarket({
    required this.activeCryptocurrencies,
    required this.markets,
    required this.totalMarketCapUsd,
    required this.totalVolumeUsd,
    required this.btcMarketCapPercentage,
    required this.marketCapChangePercentage24hUsd,
  });

  @override
  List<Object?> get props {
    return [
      activeCryptocurrencies,
      markets,
      totalMarketCapUsd,
      totalVolumeUsd,
      btcMarketCapPercentage,
      marketCapChangePercentage24hUsd,
    ];
  }
}
