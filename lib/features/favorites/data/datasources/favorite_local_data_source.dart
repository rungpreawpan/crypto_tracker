import 'package:hive/hive.dart';

class FavoriteLocalDataSource {
  final Box<String> box;

  const FavoriteLocalDataSource(this.box);

  Future<List<String>> getFavoriteCoinIds() async {
    return box.values.toList();
  }

  Future<bool> isFavorite(String coinId) async {
    return box.containsKey(coinId);
  }

  Future<void> addFavorite(String coinId) async {
    await box.put(coinId, coinId);
  }

  Future<void> removeFavorite(String coinId) async {
    await box.delete(coinId);
  }
}
