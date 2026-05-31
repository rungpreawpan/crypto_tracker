import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../../favorites/presentation/providers/favorite_providers.dart';
import '../../../settings/domain/entities/app_currency.dart';
import '../../../settings/presentation/providers/currency_providers.dart';
import '../providers/coin_detail_providers.dart';
import '../state/coin_detail_state.dart';

class CoinDetailViewModel extends AsyncNotifier<CoinDetailState> {
  final String coinId;

  CoinDetailViewModel(this.coinId);

  @override
  Future<CoinDetailState> build() async {
    final currency = ref.watch(appCurrencyProvider);
    final connected = await ref.read(networkInfoProvider).isConnected;
    final coin = await ref
        .read(getCoinDetailUseCaseProvider)
        .call(coinId: coinId, currencyCode: currency.code, forceRefresh: false);
    final favorites = await ref.read(getFavoritesUseCaseProvider).call();

    return CoinDetailState.initial().copyWith(
      coin: coin,
      isFavorite: favorites.contains(coinId),
      isOffline: !connected,
    );
  }

  Future<void> toggleFavorite() async {
    final currentState = state.asData?.value;
    final coin = currentState?.coin;

    if (currentState == null || coin == null) {
      return;
    }

    final favorite = await ref
        .read(toggleFavoriteUseCaseProvider)
        .call(coin.id);
    ref.invalidate(favoritesViewModelProvider);

    state = AsyncValue.data(currentState.copyWith(isFavorite: favorite));
  }

  Future<void> refresh() async {
    final currency = ref.read(appCurrencyProvider);
    final currentState = state.asData?.value ?? CoinDetailState.initial();

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final connected = await ref.read(networkInfoProvider).isConnected;
      final coin = await ref
          .read(getCoinDetailUseCaseProvider)
          .call(
            coinId: coinId,
            currencyCode: currency.code,
            forceRefresh: true,
          );

      return currentState.copyWith(coin: coin, isOffline: !connected);
    });
  }
}
