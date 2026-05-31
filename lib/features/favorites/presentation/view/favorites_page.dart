import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../features/market/domain/entities/market_coin.dart';
import '../../../../features/market/domain/entities/trending_coin.dart';
import '../../../../features/market/presentation/providers/market_providers.dart';
import '../providers/favorite_providers.dart';
import '../state/favorite_sort_option.dart';
import '../widgets/edit_favorites_view.dart';
import '../widgets/favorite_coin_tile.dart';
import '../widgets/favorites_empty_state_view.dart';
import '../widgets/favorites_list_meta_header.dart';
import '../widgets/favorites_no_results_view.dart';
import '../widgets/favorites_offline_banner.dart';
import '../widgets/favorites_search_section.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAsync = ref.watch(favoritesViewModelProvider);
    final favoriteIds = favoriteAsync.asData?.value ?? [];
    final editMode = ref.watch(favoriteEditModeProvider);
    final searchQuery = ref.watch(favoritesSearchQueryProvider);
    final sortOption = ref.watch(favoritesSortProvider);
    final marketAsync = ref.watch(marketViewModelProvider);
    final marketState = marketAsync.asData?.value;
    final displayCoins = _displayCoins(
      marketState?.coins ?? [],
      marketState?.trendingCoins ?? [],
    );
    final favoriteCoins = _favoriteCoins(displayCoins, favoriteIds);
    final visibleCoins = _sortedCoins(
      _filteredCoins(favoriteCoins, searchQuery),
      sortOption,
    );

    if (favoriteAsync.isLoading && favoriteAsync.asData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (favoriteAsync.hasError && favoriteAsync.asData == null) {
      return AppErrorView(
        message: favoriteAsync.error.toString(),
        onRetry: () {
          ref.invalidate(favoritesViewModelProvider);
        },
      );
    }

    if (favoriteIds.isEmpty) {
      _resetEditModeIfNeeded(ref, editMode);
      return const FavoritesEmptyStateView();
    }

    if (marketAsync.isLoading && marketState == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (marketAsync.hasError && marketState == null) {
      return AppErrorView(
        message: marketAsync.error.toString(),
        onRetry: () {
          ref.invalidate(marketViewModelProvider);
        },
      );
    }

    if (marketState == null) {
      return AppErrorView(
        message: 'errors.favorite_market_data_unavailable',
        onRetry: () {
          ref.invalidate(marketViewModelProvider);
        },
      );
    }

    if (editMode) {
      return EditFavoritesView(
        favoriteCoins: favoriteCoins,
        availableCoins: _availableCoins(displayCoins, favoriteIds),
        onToggleFavorite: (coinId) {
          _toggleFavorite(ref, coinId);
        },
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      children: [
        if (marketState.isOffline) const FavoritesOfflineBanner(),
        if (marketState.isOffline)
          const SizedBox(height: AppSpacing.md),
        FavoritesSearchSection(
          onChanged: (value) {
            ref.read(favoritesSearchQueryProvider.notifier).updateQuery(value);
          },
        ),
        const SizedBox(height: AppSpacing.md),
        FavoritesListMetaHeader(
          count: visibleCoins.length,
          selectedOption: sortOption,
          onSelected: (option) {
            ref.read(favoritesSortProvider.notifier).updateSort(option);
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        if (visibleCoins.isEmpty)
          const FavoritesNoResultsView()
        else
          for (var index = 0; index < visibleCoins.length; index++)
            Padding(
              padding: EdgeInsets.only(
                bottom: index == visibleCoins.length - 1 ? 0.0 : AppSpacing.sm,
              ),
              child: FavoriteCoinTile(
                coin: visibleCoins[index],
                onTap: () {
                  context.pushNamed(
                    'coinDetail',
                    pathParameters: {'id': visibleCoins[index].id},
                  );
                },
              ),
            ),
      ],
    );
  }

  List<MarketCoin> _favoriteCoins(
    List<MarketCoin> displayCoins,
    List<String> favoriteIds,
  ) {
    return displayCoins.where((coin) {
      return favoriteIds.contains(coin.id);
    }).toList();
  }

  List<MarketCoin> _availableCoins(
    List<MarketCoin> displayCoins,
    List<String> favoriteIds,
  ) {
    return displayCoins.where((coin) {
      return !favoriteIds.contains(coin.id);
    }).toList();
  }

  List<MarketCoin> _displayCoins(
    List<MarketCoin> marketCoins,
    List<TrendingCoin> trendingCoins,
  ) {
    final coinsById = <String, MarketCoin>{};

    for (final coin in marketCoins) {
      coinsById[coin.id] = coin;
    }

    for (final coin in trendingCoins) {
      coinsById.putIfAbsent(coin.id, () {
        return _marketCoinFromTrendingCoin(coin);
      });
    }

    return coinsById.values.toList();
  }

  MarketCoin _marketCoinFromTrendingCoin(TrendingCoin coin) {
    return MarketCoin(
      id: coin.id,
      symbol: coin.symbol,
      name: coin.name,
      image: coin.image,
      currentPrice: coin.price,
      marketCap: 0,
      marketCapRank: coin.marketCapRank,
      priceChangePercentage24h: coin.priceChangePercentage24h,
      sparklinePrices: const [],
    );
  }

  List<MarketCoin> _filteredCoins(List<MarketCoin> coins, String searchQuery) {
    final query = searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return coins;
    }

    return coins.where((coin) {
      return coin.name.toLowerCase().contains(query) ||
          coin.symbol.toLowerCase().contains(query);
    }).toList();
  }

  List<MarketCoin> _sortedCoins(
    List<MarketCoin> coins,
    FavoriteSortOption option,
  ) {
    final sortedCoins = [...coins];

    sortedCoins.sort((first, second) {
      if (option == FavoriteSortOption.price) {
        return second.currentPrice.compareTo(first.currentPrice);
      }

      if (option == FavoriteSortOption.change24h) {
        return second.priceChangePercentage24h.compareTo(
          first.priceChangePercentage24h,
        );
      }

      return second.marketCap.compareTo(first.marketCap);
    });

    return sortedCoins;
  }

  void _toggleFavorite(WidgetRef ref, String coinId) {
    ref.read(favoritesViewModelProvider.notifier).toggleFavorite(coinId);
  }

  void _resetEditModeIfNeeded(WidgetRef ref, bool editMode) {
    if (!editMode) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoriteEditModeProvider.notifier).stopEditing();
    });
  }
}
