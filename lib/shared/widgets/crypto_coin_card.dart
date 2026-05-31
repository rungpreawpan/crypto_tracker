import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/currency_formatter.dart';
import 'coin_avatar.dart';
import 'sparkline_chart.dart';

class CryptoCoinCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String symbol;
  final num currentPrice;
  final num marketCap;
  final num priceChangePercentage24h;
  final List<double> sparklinePrices;
  final String currencySymbol;
  final VoidCallback onTap;

  const CryptoCoinCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.marketCap,
    required this.priceChangePercentage24h,
    required this.sparklinePrices,
    required this.currencySymbol,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final changeColor = priceChangePercentage24h >= 0
        ? AppColors.positive
        : const Color(0xFFFF7AA8);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            children: [
              _identitySection(context),
              const SizedBox(width: AppSpacing.xs),
              _sparklineSection(changeColor),
              _priceSection(context, changeColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _identitySection(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Row(
        children: [
          CoinAvatar(imageUrl: imageUrl, size: 36.0),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.56),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sparklineSection(Color changeColor) {
    return Expanded(
      flex: 4,
      child: SizedBox(
        height: 44.0,
        child: SparklineChart(color: changeColor, points: _sparklinePoints()),
      ),
    );
  }

  Widget _priceSection(BuildContext context, Color changeColor) {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            CurrencyFormatter.standard(currentPrice, symbol: currencySymbol),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.xs),
          _changePill(context, changeColor),
        ],
      ),
    );
  }

  Widget _changePill(BuildContext context, Color changeColor) {
    final backgroundColor = priceChangePercentage24h >= 0
        ? AppColors.positive.withValues(alpha: 0.2)
        : const Color(0xFFFF7AA8).withValues(alpha: 0.24);
    final icon = priceChangePercentage24h >= 0
        ? Icons.north_east
        : Icons.south_east;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.0, color: changeColor),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '${priceChangePercentage24h.abs().toStringAsFixed(2)}%',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: changeColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  List<double> _sparklinePoints() {
    if (sparklinePrices.length >= 2) {
      return sparklinePrices;
    }

    if (priceChangePercentage24h >= 0) {
      return const [
        18.0,
        20.0,
        19.0,
        24.0,
        28.0,
        27.0,
        30.0,
        34.0,
        32.0,
        35.0,
        38.0,
        42.0,
      ];
    }

    return const [
      42.0,
      36.0,
      38.0,
      32.0,
      30.0,
      29.0,
      26.0,
      24.0,
      22.0,
      25.0,
      27.0,
      21.0,
    ];
  }
}
