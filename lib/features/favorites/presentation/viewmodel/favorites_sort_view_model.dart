import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/favorite_sort_option.dart';

class FavoritesSortViewModel extends Notifier<FavoriteSortOption> {
  @override
  FavoriteSortOption build() {
    return FavoriteSortOption.marketCap;
  }

  void updateSort(FavoriteSortOption option) {
    state = option;
  }
}
