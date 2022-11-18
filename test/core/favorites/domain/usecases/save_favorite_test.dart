import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/core/favorites/domain/usecases/usecases.dart';

import '../../../../utils/faux.dart';
import '../repositories/favorites_repository_test.mocks.dart';

void main() {
  late MockFavoritesRepository mockFavoritesRepository;
  late SaveFavorite saveFavoriteUseCase;

  setUp(() {
    mockFavoritesRepository = MockFavoritesRepository();
    saveFavoriteUseCase = SaveFavorite(favoritesRepository: mockFavoritesRepository);
  });

  group('Save favorite use case', () {
    final characterId = Faux.character.id;

    test('should successfully persist character ID locally', () async {
      when(mockFavoritesRepository.save(characterId: characterId)).thenAnswer((_) async => const Right(true));

      final sut = await saveFavoriteUseCase(characterId);

      expect(sut, const Right(true));
      verify(mockFavoritesRepository.save(characterId: characterId)).called(1);
      verifyNoMoreInteractions(mockFavoritesRepository);
    });

    test('should fail to persist character ID locally', () async {
      when(mockFavoritesRepository.save(characterId: characterId)).thenAnswer((_) async => const Left(AppError(properties: [])));

      final sut = await saveFavoriteUseCase(characterId);

      expect(sut, const Left(AppError(properties: [])));
      verify(mockFavoritesRepository.save(characterId: characterId)).called(1);
      verifyNoMoreInteractions(mockFavoritesRepository);
    });
  });
}
