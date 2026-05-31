import '../repositories/favorite_repository.dart';

class GetFavoritesUseCase {
  final FavoriteRepository repository;

  const GetFavoritesUseCase(this.repository);

  Future<List<String>> call() {
    return repository.getFavoriteCoinIds();
  }
}
