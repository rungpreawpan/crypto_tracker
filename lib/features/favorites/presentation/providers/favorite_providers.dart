import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../data/datasources/favorite_local_data_source.dart';
import '../../data/repositories/favorite_repository_impl.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../../domain/usecases/get_favorites_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';
import '../state/favorite_sort_option.dart';
import '../viewmodel/favorites_edit_mode_view_model.dart';
import '../viewmodel/favorites_search_query_view_model.dart';
import '../viewmodel/favorites_sort_view_model.dart';
import '../viewmodel/favorites_view_model.dart';

final favoriteLocalDataSourceProvider = Provider<FavoriteLocalDataSource>((
  ref,
) {
  return FavoriteLocalDataSource(ref.watch(favoriteCoinBoxProvider));
});

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepositoryImpl(ref.watch(favoriteLocalDataSourceProvider));
});

final getFavoritesUseCaseProvider = Provider<GetFavoritesUseCase>((ref) {
  return GetFavoritesUseCase(ref.watch(favoriteRepositoryProvider));
});

final toggleFavoriteUseCaseProvider = Provider<ToggleFavoriteUseCase>((ref) {
  return ToggleFavoriteUseCase(ref.watch(favoriteRepositoryProvider));
});

final favoritesViewModelProvider =
    AsyncNotifierProvider<FavoritesViewModel, List<String>>(() {
      return FavoritesViewModel();
    });

final favoriteEditModeProvider =
    NotifierProvider<FavoritesEditModeViewModel, bool>(() {
      return FavoritesEditModeViewModel();
    });

final favoritesSearchQueryProvider =
    NotifierProvider<FavoritesSearchQueryViewModel, String>(() {
      return FavoritesSearchQueryViewModel();
    });

final favoritesSortProvider =
    NotifierProvider<FavoritesSortViewModel, FavoriteSortOption>(() {
      return FavoritesSortViewModel();
    });
