import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../features/market/domain/entities/market_coin.dart';
import '../../../../shared/widgets/coin_avatar.dart';
import '../../../settings/domain/entities/app_currency.dart';
import '../../../settings/presentation/providers/currency_providers.dart';

class EditFavoritesView extends ConsumerWidget {
  final List<MarketCoin> favoriteCoins;
  final List<MarketCoin> availableCoins;
  final ValueChanged<String> onToggleFavorite;

  const EditFavoritesView({
    super.key,
    required this.favoriteCoins,
    required this.availableCoins,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      itemCount: _itemCount(),
      itemBuilder: (context, index) {
        return _itemAtIndex(context, ref, index);
      },
    );
  }

  int _itemCount() {
    final hasAvailableCoins = availableCoins.isNotEmpty;
    var count = favoriteCoins.length;

    if (hasAvailableCoins) {
      count += 2;
      count += availableCoins.length;
    }

    return count;
  }

  Widget _itemAtIndex(BuildContext context, WidgetRef ref, int index) {
    final favoriteCount = favoriteCoins.length;
    final hasAvailableCoins = availableCoins.isNotEmpty;

    if (index < favoriteCount) {
      return _sectionTile(
        context,
        ref,
        favoriteCoins[index],
        favorite: true,
        isFirst: index == 0,
        isLast: index == favoriteCount - 1 && !hasAvailableCoins,
        addBottomGap: index == favoriteCount - 1 && hasAvailableCoins,
      );
    }

    final availableHeaderIndex = favoriteCount;
    final availableHeaderSpacerIndex = favoriteCount + 1;
    final availableFirstItemIndex = favoriteCount + 2;

    if (hasAvailableCoins && index == availableHeaderIndex) {
      return Text(
        'favorites.more_coins'.tr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.72),
        ),
      );
    }

    if (hasAvailableCoins && index == availableHeaderSpacerIndex) {
      return const SizedBox(height: AppSpacing.sm);
    }

    if (hasAvailableCoins) {
      final availableIndex = index - availableFirstItemIndex;
      final isLastAvailableItem = availableIndex == availableCoins.length - 1;

      return _sectionTile(
        context,
        ref,
        availableCoins[availableIndex],
        favorite: false,
        isFirst: availableIndex == 0,
        isLast: isLastAvailableItem,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _sectionTile(
    BuildContext context,
    WidgetRef ref,
    MarketCoin coin, {
    required bool favorite,
    required bool isFirst,
    required bool isLast,
    bool addBottomGap = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: addBottomGap ? AppSpacing.lg : 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.74),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(isFirst ? AppRadius.md : 0.0),
            bottom: Radius.circular(isLast ? AppRadius.md : 0.0),
          ),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.outline.withValues(alpha: 0.08),
          ),
        ),
        child: _coinTile(
          context,
          ref,
          coin,
          favorite: favorite,
          showDivider: !isLast,
        ),
      ),
    );
  }

  Widget _coinTile(
    BuildContext context,
    WidgetRef ref,
    MarketCoin coin, {
    required bool favorite,
    required bool showDivider,
  }) {
    final changeColor = coin.priceChangePercentage24h >= 0
        ? AppColors.positive
        : AppColors.negative;
    final currency = ref.watch(appCurrencyProvider);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: showDivider
            ? Border(
                bottom: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.06),
                ),
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {
                onToggleFavorite(coin.id);
              },
              icon: Icon(
                favorite ? Icons.remove_circle : Icons.add_circle,
                color: favorite ? AppColors.negative : AppColors.positive,
              ),
            ),
            CoinAvatar(imageUrl: coin.image, size: 36.0),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: _coinIdentity(context, coin)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  CurrencyFormatter.standard(
                    coin.currentPrice,
                    symbol: currency.symbol,
                  ),
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: AppSpacing.xs),
                _changePill(
                  context,
                  changeColor,
                  coin.priceChangePercentage24h,
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
        ),
      ),
    );
  }

  Widget _coinIdentity(BuildContext context, MarketCoin coin) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          coin.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        Text(
          coin.symbol.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _changePill(
    BuildContext context,
    Color changeColor,
    num priceChangePercentage24h,
  ) {
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
}
