import 'package:crypto_tracker/features/favorites/domain/usecases/toggle_favorite_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../support/mocks/mock_favorite_repository.dart';

void main() {
  late MockFavoriteRepository repository;
  late ToggleFavoriteUseCase useCase;

  setUp(() {
    repository = MockFavoriteRepository();
    useCase = ToggleFavoriteUseCase(repository);
  });

  test('returns true and adds favorite when coin is not favorite', () async {
    when(() {
      return repository.isFavorite('bitcoin');
    }).thenAnswer((_) async {
      return false;
    });
    when(() {
      return repository.addFavorite('bitcoin');
    }).thenAnswer((_) async {});

    final result = await useCase.call('bitcoin');

    expect(result, isTrue);
    verify(() {
      return repository.isFavorite('bitcoin');
    }).called(1);
    verify(() {
      return repository.addFavorite('bitcoin');
    }).called(1);
    verifyNever(() {
      return repository.removeFavorite(any());
    });
  });

  test('returns false and removes favorite when coin is already favorite', () async {
    when(() {
      return repository.isFavorite('bitcoin');
    }).thenAnswer((_) async {
      return true;
    });
    when(() {
      return repository.removeFavorite('bitcoin');
    }).thenAnswer((_) async {});

    final result = await useCase.call('bitcoin');

    expect(result, isFalse);
    verify(() {
      return repository.isFavorite('bitcoin');
    }).called(1);
    verify(() {
      return repository.removeFavorite('bitcoin');
    }).called(1);
    verifyNever(() {
      return repository.addFavorite(any());
    });
  });
}
