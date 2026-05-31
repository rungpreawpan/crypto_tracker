import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/widgets/coin_avatar.dart';
import '../../../settings/domain/entities/app_currency.dart';
import '../../../settings/presentation/providers/currency_providers.dart';
import '../../domain/entities/trending_coin.dart';

class TrendingCoinSection extends ConsumerWidget {
  final List<TrendingCoin> coins;

  const TrendingCoinSection({super.key, required this.coins});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (coins.isEmpty) {
      return const SizedBox.shrink();
    }
    final currency = ref.watch(appCurrencyProvider);
    final visibleCoins = coins.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'market.trending_24h'.tr().toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 10.0,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.48),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed('trendingCoins');
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                minimumSize: const Size(0.0, 32.0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'market.trending_count'.tr(
                  namedArgs: {'count': coins.length.toString()},
                ),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.52),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 64.0,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: visibleCoins.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: AppSpacing.sm);
            },
            itemBuilder: (context, index) {
              return _trendingCoinTile(context, visibleCoins[index], currency);
            },
          ),
        ),
      ],
    );
  }

  Widget _trendingCoinTile(
    BuildContext context,
    TrendingCoin coin,
    AppCurrency currency,
  ) {
    final changeColor = coin.priceChangePercentage24h >= 0
        ? AppColors.positive
        : AppColors.negative;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md),
      onTap: () {
        context.pushNamed('coinDetail', pathParameters: {'id': coin.id});
      },
      child: Container(
        width: 168.0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.outline.withValues(alpha: 0.16),
          ),
        ),
        child: Row(
          children: [
            CoinAvatar(imageUrl: coin.image, size: 34.0),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 1.0),
                  Text(
                    coin.symbol.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.58),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _priceText(coin, currency),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 2.0),
                Text(
                  CurrencyFormatter.percent(coin.priceChangePercentage24h),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: changeColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _priceText(TrendingCoin coin, AppCurrency currency) {
    if (coin.price <= 0) {
      return '#${coin.marketCapRank}';
    }

    return CurrencyFormatter.standard(coin.price, symbol: currency.symbol);
  }
}
