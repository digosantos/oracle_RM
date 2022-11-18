import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/core/favorites/domain/usecases/usecases.dart';

import '../repositories/favorites_repository_test.mocks.dart';

void main() {
  late MockFavoritesRepository mockFavoritesRepository;
  late RemoveFavorite removeFavoriteUseCase;

  setUp(() {
    mockFavoritesRepository = MockFavoritesRepository();
    removeFavoriteUseCase = RemoveFavorite(favoritesRepository: mockFavoritesRepository);
  });

  group('Remove favorite use case', () {
    const characterId = '1';

    test('should successfully remove favorite ID from local storage', () async {
      when(mockFavoritesRepository.remove()).thenAnswer((_) async => const Right(true));

      final sut = await removeFavoriteUseCase(characterId);

      expect(sut, const Right(true));
      verify(mockFavoritesRepository.remove()).called(1);
      verifyNoMoreInteractions(mockFavoritesRepository);
    });

    test('should fail to remove favorite ID from local storage', () async {
      when(mockFavoritesRepository.remove()).thenAnswer((_) async => const Left(AppError(properties: [])));

      final sut = await removeFavoriteUseCase(characterId);

      expect(sut, const Left(AppError(properties: [])));
      verify(mockFavoritesRepository.remove()).called(1);
      verifyNoMoreInteractions(mockFavoritesRepository);
    });
  });
}
