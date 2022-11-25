import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/core/favorites/data/repositories/repositories.dart';

import '../../../../utils/faux.dart';
import '../../../characters/domain/repositories/repositories_mocks.dart';
import '../datasources/datasources.dart';

void main() {
  late MockFavoritesLocalDataSource mockFavoritesLocalDataSource;
  late MockCharactersRepository mockCharactersRepository;
  late FavoritesRepositoryImpl favoritesRepositoryImpl;

  setUp(() {
    mockCharactersRepository = MockCharactersRepository();
    mockFavoritesLocalDataSource = MockFavoritesLocalDataSource();
    favoritesRepositoryImpl = FavoritesRepositoryImpl(
      favoritesLocalDataSource: mockFavoritesLocalDataSource,
      charactersRepository: mockCharactersRepository,
    );
  });

  group('FavoriteRepositoryImpl getIds method', () {
    const List<String> favoriteIdsList = ['999', '2'];

    test(
        'should return list of String when retrieving favorites from local storage',
        () async {
      when(mockFavoritesLocalDataSource.getAll())
          .thenAnswer((_) => favoriteIdsList);

      final sut = await favoritesRepositoryImpl.getIds();

      expect(sut, const Right(favoriteIdsList));
      verify(mockFavoritesLocalDataSource.getAll());
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });

    test(
        'should return AppError when fails to retrieve favorites from local storage',
        () async {
      when(mockFavoritesLocalDataSource.getAll())
          .thenThrow(const AppError(properties: []));

      final sut = await favoritesRepositoryImpl.getIds();

      expect(sut, const Left(AppError(properties: [])));
      verify(mockFavoritesLocalDataSource.getAll());
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });
  });

  group('FavoriteRepositoryImpl update method', () {
    final characterId = Faux.character.id;
    const updatedFavorite = Faux.updatedFavorite;

    test(
        'should return true when characterId is successfully persisted locally',
        () async {
      when(mockFavoritesLocalDataSource.update(characterId: characterId))
          .thenAnswer((_) async => updatedFavorite);

      final sut =
          await favoritesRepositoryImpl.update(characterId: characterId);

      expect(sut, const Right(updatedFavorite));
      verify(mockFavoritesLocalDataSource.update(characterId: characterId));
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });

    test('should return AppError when fails to persist characterId locally',
        () async {
      when(mockFavoritesLocalDataSource.update(characterId: characterId))
          .thenThrow(const AppError(properties: []));

      final sut =
          await favoritesRepositoryImpl.update(characterId: characterId);

      expect(sut, const Left(AppError(properties: [])));
      verify(mockFavoritesLocalDataSource.update(characterId: characterId));
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });
  });
}
