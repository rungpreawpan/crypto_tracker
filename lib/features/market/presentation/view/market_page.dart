import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/offline_state_widget.dart';
import '../providers/market_providers.dart';
import '../state/market_state.dart';
import '../widgets/coin_list_section.dart';
import '../widgets/global_market_card.dart';
import '../widgets/market_loading_view.dart';
import '../widgets/market_pinned_search_header.dart';
import '../widgets/trending_coin_section.dart';

class MarketPage extends ConsumerWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final marketState = ref.watch(marketViewModelProvider);

    return marketState.when(
      data: (state) {
        return _marketContent(context, ref, state);
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
        return const MarketLoadingView();
      },
    );
  }

  Widget _marketContent(
    BuildContext context,
    WidgetRef ref,
    MarketState state,
  ) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;

        if (metrics.pixels >= metrics.maxScrollExtent - 240) {
          ref.read(marketViewModelProvider.notifier).loadNextPage();
        }

        return false;
      },
      child: RefreshIndicator(
        onRefresh: () {
          return ref.read(marketViewModelProvider.notifier).refresh();
        },
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.isOffline) const OfflineStateWidget(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                      AppSpacing.sm,
                    ),
                    child: _marketHeaderContent(ref, state),
                  ),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: MarketPinnedSearchHeader(
                onSearchChanged: (query) {
                  ref
                      .read(marketViewModelProvider.notifier)
                      .updateSearchQuery(query);
                },
              ),
            ),
            if (state.filteredCoins.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyStateView(
                  title: 'market.empty_title'.tr(),
                  message: 'market.empty_message'.tr(),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.xs,
                  AppSpacing.md,
                  AppSpacing.lg,
                ),
                sliver: CoinListSection(
                  coins: state.filteredCoins,
                  isLoadingMore: state.isLoadingMore,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _marketHeaderContent(WidgetRef ref, MarketState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.globalMarket != null)
          GlobalMarketCard(market: state.globalMarket!),
        const SizedBox(height: AppSpacing.md),
        TrendingCoinSection(coins: state.trendingCoins),
      ],
    );
  }
}
