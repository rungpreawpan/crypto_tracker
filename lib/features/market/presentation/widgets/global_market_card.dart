import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../settings/domain/entities/app_currency.dart';
import '../../../settings/presentation/providers/currency_providers.dart';
import '../../domain/entities/global_market.dart';

class GlobalMarketCard extends ConsumerWidget {
  final GlobalMarket market;

  const GlobalMarketCard({super.key, required this.market});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(appCurrencyProvider);
    final changeColor = market.marketCapChangePercentage24hUsd >= 0
        ? AppColors.positive
        : AppColors.negative;

    return Container(
      constraints: const BoxConstraints(minHeight: 72.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.16),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: _primaryMetric(
                context,
                label: 'market.global_market_cap'.tr(),
                value: CurrencyFormatter.compact(
                  market.totalMarketCapUsd,
                  symbol: currency.symbol,
                ),
                trailing: _changeLabel(context, changeColor),
              ),
            ),
            _verticalDivider(context),
            Expanded(
              flex: 2,
              child: _primaryMetric(
                context,
                label: 'market.vol_24h'.tr(),
                value: CurrencyFormatter.compact(
                  market.totalVolumeUsd,
                  symbol: currency.symbol,
                ),
                valueStyle: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _primaryMetric(
    BuildContext context, {
    required String label,
    required String value,
    TextStyle? valueStyle,
    Widget? trailing,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 10.0,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.42),
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Flexible(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    valueStyle ??
                    Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            ?_trailingSpacing(trailing),
            ?trailing,
          ],
        ),
      ],
    );
  }

  Widget? _trailingSpacing(Widget? trailing) {
    if (trailing == null) {
      return null;
    }

    return const SizedBox(width: AppSpacing.sm);
  }

  Widget _verticalDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: VerticalDivider(
        width: 1.0,
        thickness: 1.0,
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
      ),
    );
  }

  Widget _changeLabel(BuildContext context, Color changeColor) {
    return Flexible(
      child: Text(
        CurrencyFormatter.percent(market.marketCapChangePercentage24hUsd),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: changeColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
