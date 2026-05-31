import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/offline_state_widget.dart';
import '../../../../shared/widgets/app_gradient_background.dart';
import '../../../../shared/widgets/crypto_coin_card.dart';
import '../../../settings/domain/entities/app_currency.dart';
import '../../../settings/presentation/providers/currency_providers.dart';
import '../../domain/entities/market_coin.dart';
import '../../domain/entities/trending_coin.dart';
import '../providers/market_providers.dart';
import '../state/market_state.dart';

class TrendingCoinsPage extends ConsumerWidget {
  const TrendingCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketState = ref.watch(marketViewModelProvider);
    final currency = ref.watch(appCurrencyProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'market.trending_coins'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: AppGradientBackground(
        child: marketState.when(
          data: (state) {
            if (state.trendingCoins.isEmpty) {
              return EmptyStateView(
                title: 'market.empty_title'.tr(),
                message: 'market.empty_message'.tr(),
              );
            }

              return RefreshIndicator(
                onRefresh: () {
                  return ref.read(marketViewModelProvider.notifier).refresh();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.md,
                    AppSpacing.xl,
                  ),
                  itemCount:
                      state.trendingCoins.length + (state.isOffline ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (state.isOffline && index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: const OfflineStateWidget(),
                      );
                    }

                    final coinIndex = state.isOffline ? index - 1 : index;
                    final coin = state.trendingCoins[coinIndex];
                    final isLastItem = coinIndex == state.trendingCoins.length - 1;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: isLastItem ? 0.0 : AppSpacing.sm,
                      ),
                      child: _trendingCoinCard(
                        context,
                        state,
                        coin,
                        currency.symbol,
                      ),
                    );
                  },
                ),
              );
          },
          error: (error, stackTrace) {
            return AppErrorView(
              message: error.toString(),
              onRetry: () {
                ref.invalidate(marketViewModelProvider);
              },
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _trendingCoinCard(
    BuildContext context,
    MarketState state,
    TrendingCoin coin,
    String currencySymbol,
  ) {
    final marketCoin = _matchingMarketCoin(coin, state);

    return CryptoCoinCard(
      imageUrl: coin.image,
      name: coin.name,
      symbol: coin.symbol,
      currentPrice: marketCoin?.currentPrice ?? coin.price,
      marketCap: marketCoin?.marketCap ?? 0,
      priceChangePercentage24h:
          marketCoin?.priceChangePercentage24h ?? coin.priceChangePercentage24h,
      sparklinePrices: marketCoin?.sparklinePrices ?? const [],
      currencySymbol: currencySymbol,
      onTap: () {
        context.pushNamed('coinDetail', pathParameters: {'id': coin.id});
      },
    );
  }

  MarketCoin? _matchingMarketCoin(
    TrendingCoin trendingCoin,
    MarketState state,
  ) {
    for (final coin in state.coins) {
      if (coin.id == trendingCoin.id) {
        return coin;
      }
    }

    return null;
  }
}
