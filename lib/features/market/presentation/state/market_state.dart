import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/global_market.dart';
import '../../domain/entities/market_coin.dart';
import '../../domain/entities/trending_coin.dart';

part 'market_state.freezed.dart';

@freezed
sealed class MarketState with _$MarketState {
  const factory MarketState({
    required List<MarketCoin> coins,
    required List<MarketCoin> filteredCoins,
    required List<TrendingCoin> trendingCoins,
    required GlobalMarket? globalMarket,
    required String searchQuery,
    required int currentPage,
    required bool isRefreshing,
    required bool isLoadingMore,
    required bool hasReachedEnd,
    required bool isOffline,
    required String? paginationError,
  }) = MarketStateData;

  factory MarketState.initial() {
    return const MarketState(
      coins: [],
      filteredCoins: [],
      trendingCoins: [],
      globalMarket: null,
      searchQuery: '',
      currentPage: 1,
      isRefreshing: false,
      isLoadingMore: false,
      hasReachedEnd: false,
      isOffline: false,
      paginationError: null,
    );
  }
}
