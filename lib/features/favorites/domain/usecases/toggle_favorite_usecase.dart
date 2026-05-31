import '../repositories/favorite_repository.dart';

class ToggleFavoriteUseCase {
  final FavoriteRepository repository;

  const ToggleFavoriteUseCase(this.repository);

  Future<bool> call(String coinId) async {
    final favorite = await repository.isFavorite(coinId);

    if (favorite) {
      await repository.removeFavorite(coinId);
      return false;
    }

    await repository.addFavorite(coinId);
    return true;
  }
}
