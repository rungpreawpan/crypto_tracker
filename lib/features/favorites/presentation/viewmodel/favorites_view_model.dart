import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorite_providers.dart';

class FavoritesViewModel extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() {
    return ref.read(getFavoritesUseCaseProvider).call();
  }

  Future<void> toggleFavorite(String coinId) async {
    final currentFavorites = state.asData?.value ?? [];
    final favorite = await ref.read(toggleFavoriteUseCaseProvider).call(coinId);

    if (favorite) {
      state = AsyncValue.data([...currentFavorites, coinId]);
      return;
    }

    state = AsyncValue.data(
      currentFavorites.where((id) {
        return id != coinId;
      }).toList(),
    );
  }
}
