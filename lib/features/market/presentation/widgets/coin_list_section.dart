import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/market_coin.dart';
import 'market_coin_row.dart';

class CoinListSection extends StatelessWidget {
  final List<MarketCoin> coins;
  final bool isLoadingMore;

  const CoinListSection({
    super.key,
    required this.coins,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: coins.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= coins.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final coin = coins[index];

        return Padding(
          padding: EdgeInsets.only(
            bottom: index == coins.length - 1 ? 0.0 : AppSpacing.sm,
          ),
          child: MarketCoinRow(
            coin: coin,
            onTap: () {
              context.pushNamed('coinDetail', pathParameters: {'id': coin.id});
            },
          ),
        );
      },
    );
  }
}
