import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../state/favorite_sort_option.dart';

class FavoritesListMetaHeader extends StatelessWidget {
  final int count;
  final FavoriteSortOption selectedOption;
  final ValueChanged<FavoriteSortOption> onSelected;

  const FavoritesListMetaHeader({
    super.key,
    required this.count,
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.66),
    );

    return Row(
      children: [
        Expanded(
          child: Text('$count ${'favorites.coins'.tr()}', style: textStyle),
        ),
        PopupMenuButton<FavoriteSortOption>(
          initialValue: selectedOption,
          offset: const Offset(0.0, 8.0),
          position: PopupMenuPosition.under,
          onSelected: onSelected,
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: FavoriteSortOption.marketCap,
                child: Text('favorites.sort_market_cap'.tr()),
              ),
              PopupMenuItem(
                value: FavoriteSortOption.price,
                child: Text('favorites.sort_price'.tr()),
              ),
              PopupMenuItem(
                value: FavoriteSortOption.change24h,
                child: Text('favorites.sort_change_24h'.tr()),
              ),
            ];
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Text(_selectedLabel(), style: textStyle),
                const Icon(Icons.keyboard_arrow_down, size: 16.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _selectedLabel() {
    if (selectedOption == FavoriteSortOption.price) {
      return 'favorites.sort_price'.tr();
    }

    if (selectedOption == FavoriteSortOption.change24h) {
      return 'favorites.sort_change_24h'.tr();
    }

    return 'favorites.sort_market_cap'.tr();
  }
}
