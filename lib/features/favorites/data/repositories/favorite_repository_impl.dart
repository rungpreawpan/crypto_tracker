import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_local_data_source.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDataSource localDataSource;

  const FavoriteRepositoryImpl(this.localDataSource);

  @override
  Future<void> addFavorite(String coinId) {
    return localDataSource.addFavorite(coinId);
  }

  @override
  Future<List<String>> getFavoriteCoinIds() {
    return localDataSource.getFavoriteCoinIds();
  }

  @override
  Future<bool> isFavorite(String coinId) {
    return localDataSource.isFavorite(coinId);
  }

  @override
  Future<void> removeFavorite(String coinId) {
    return localDataSource.removeFavorite(coinId);
  }
}
