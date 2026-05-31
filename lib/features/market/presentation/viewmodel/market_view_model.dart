import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/di/core_providers.dart';
import '../../../settings/domain/entities/app_currency.dart';
import '../../../settings/presentation/providers/currency_providers.dart';
import '../../domain/entities/market_coin.dart';
import '../providers/market_providers.dart';
import '../state/market_state.dart';

class MarketViewModel extends AsyncNotifier<MarketState> {
  Timer? searchDebounce;

  @override
  Future<MarketState> build() async {
    ref.onDispose(cancelSearchDebounce);
    return loadInitialMarket();
  }

  Future<MarketState> loadInitialMarket() async {
    final currency = ref.watch(appCurrencyProvider);
    final connected = await ref.read(networkInfoProvider).isConnected;
    final globalMarket = await ref
        .read(getGlobalMarketUseCaseProvider)
        .call(currencyCode: currency.code, forceRefresh: false);
    final trendingCoins = await ref
        .read(getTrendingCoinsUseCaseProvider)
        .call(forceRefresh: false);
    final coins = await ref
        .read(getMarketCoinsUseCaseProvider)
        .call(page: 1, currencyCode: currency.code, forceRefresh: false);

    return MarketState.initial().copyWith(
      globalMarket: globalMarket,
      trendingCoins: trendingCoins,
      coins: coins,
      filteredCoins: coins,
      isOffline: !connected,
      hasReachedEnd: coins.length < ApiConstants.marketPageSize,
    );
  }

  Future<void> refresh() async {
    final currency = ref.read(appCurrencyProvider);
    final currentState = state.asData?.value ?? MarketState.initial();

    state = AsyncValue.data(currentState.copyWith(isRefreshing: true));

    try {
      final connected = await ref.read(networkInfoProvider).isConnected;
      final globalMarket = await ref
          .read(getGlobalMarketUseCaseProvider)
          .call(currencyCode: currency.code, forceRefresh: true);
      final trendingCoins = await ref
          .read(getTrendingCoinsUseCaseProvider)
          .call(forceRefresh: true);
      final coins = await ref
          .read(getMarketCoinsUseCaseProvider)
          .call(page: 1, currencyCode: currency.code, forceRefresh: true);
      final refreshedState = currentState.copyWith(
        globalMarket: globalMarket,
        trendingCoins: trendingCoins,
        coins: coins,
        currentPage: 1,
        isRefreshing: false,
        isLoadingMore: false,
        hasReachedEnd: coins.length < ApiConstants.marketPageSize,
        isOffline: !connected,
        paginationError: null,
      );

      state = AsyncValue.data(applySearch(refreshedState));
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadNextPage() async {
    final currency = ref.read(appCurrencyProvider);
    final currentState = state.asData?.value;

    if (currentState == null) {
      return;
    }

    if (currentState.isLoadingMore || currentState.hasReachedEnd) {
      return;
    }

    final nextPage = currentState.currentPage + 1;
    state = AsyncValue.data(
      currentState.copyWith(isLoadingMore: true, paginationError: null),
    );

    try {
      final nextCoins = await ref
          .read(getMarketCoinsUseCaseProvider)
          .call(
            page: nextPage,
            currencyCode: currency.code,
            forceRefresh: false,
          );
      final allCoins = [...currentState.coins, ...nextCoins];
      final nextState = currentState.copyWith(
        coins: allCoins,
        currentPage: nextPage,
        isLoadingMore: false,
        hasReachedEnd: nextCoins.length < ApiConstants.marketPageSize,
      );

      state = AsyncValue.data(applySearch(nextState));
    } catch (error) {
      state = AsyncValue.data(
        currentState.copyWith(
          isLoadingMore: false,
          paginationError: error.toString(),
        ),
      );
    }
  }

  void updateSearchQuery(String query) {
    final currentState = state.asData?.value;

    if (currentState == null) {
      return;
    }

    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(milliseconds: 350), () {
      final latestState = state.asData?.value;

      if (latestState == null) {
        return;
      }

      state = AsyncValue.data(
        applySearch(latestState.copyWith(searchQuery: query.trim())),
      );
    });
  }

  MarketState applySearch(MarketState currentState) {
    final query = currentState.searchQuery.toLowerCase();

    if (query.isEmpty) {
      return currentState.copyWith(filteredCoins: currentState.coins);
    }

    final filteredCoins = currentState.coins.where((coin) {
      return coinMatchesQuery(coin, query);
    }).toList();

    return currentState.copyWith(filteredCoins: filteredCoins);
  }

  bool coinMatchesQuery(MarketCoin coin, String query) {
    return coin.name.toLowerCase().contains(query) ||
        coin.symbol.toLowerCase().contains(query);
  }

  void cancelSearchDebounce() {
    searchDebounce?.cancel();
  }
}
