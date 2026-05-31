abstract class FavoriteRepository {
  Future<List<String>> getFavoriteCoinIds();

  Future<bool> isFavorite(String coinId);

  Future<void> addFavorite(String coinId);

  Future<void> removeFavorite(String coinId);
}
