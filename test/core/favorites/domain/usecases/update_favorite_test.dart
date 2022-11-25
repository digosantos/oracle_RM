import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/core/favorites/domain/usecases/usecases.dart';

import '../../../../utils/faux.dart';
import '../repositories/favorites_repository_test.mocks.dart';

void main() {
  late MockFavoritesRepository mockFavoritesRepository;
  late UpdateFavorite updateFavoriteUseCase;

  setUp(() {
    mockFavoritesRepository = MockFavoritesRepository();
    updateFavoriteUseCase = UpdateFavorite(favoritesRepository: mockFavoritesRepository);
  });

  group('Update favorite use case', () {
    final characterId = Faux.character.id;
    const updatedFavorite = Faux.updatedFavorite;

    test('should successfully persist character ID locally', () async {
      when(mockFavoritesRepository.update(characterId: characterId)).thenAnswer((_) async => const Right(updatedFavorite));

      final sut = await updateFavoriteUseCase(characterId);

      expect(sut, const Right(updatedFavorite));
      verify(mockFavoritesRepository.update(characterId: characterId)).called(1);
      verifyNoMoreInteractions(mockFavoritesRepository);
    });

    test('should fail to persist character ID locally', () async {
      when(mockFavoritesRepository.update(characterId: characterId)).thenAnswer((_) async => const Left(AppError(properties: [])));

      final sut = await updateFavoriteUseCase(characterId);

      expect(sut, const Left(AppError(properties: [])));
      verify(mockFavoritesRepository.update(characterId: characterId)).called(1);
      verifyNoMoreInteractions(mockFavoritesRepository);
    });
  });
}
