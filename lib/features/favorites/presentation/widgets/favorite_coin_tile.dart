import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/market/domain/entities/market_coin.dart';
import '../../../../shared/widgets/crypto_coin_card.dart';
import '../../../settings/domain/entities/app_currency.dart';
import '../../../settings/presentation/providers/currency_providers.dart';

class FavoriteCoinTile extends ConsumerWidget {
  final MarketCoin coin;
  final VoidCallback onTap;

  const FavoriteCoinTile({super.key, required this.coin, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(appCurrencyProvider);

    return CryptoCoinCard(
      imageUrl: coin.image,
      name: coin.name,
      symbol: coin.symbol,
      currentPrice: coin.currentPrice,
      marketCap: coin.marketCap,
      priceChangePercentage24h: coin.priceChangePercentage24h,
      sparklinePrices: coin.sparklinePrices,
      currencySymbol: currency.symbol,
      onTap: onTap,
    );
  }
}
