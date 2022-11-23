import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/core/favorites/data/repositories/repositories.dart';

import '../../../../utils/faux.dart';
import '../datasources/datasources.dart';

void main() {
  late MockFavoritesLocalDataSource mockFavoritesLocalDataSource;
  late FavoritesRepositoryImpl favoritesRepositoryImpl;

  setUp(() {
    mockFavoritesLocalDataSource = MockFavoritesLocalDataSource();
    favoritesRepositoryImpl = FavoritesRepositoryImpl(favoritesLocalDataSource: mockFavoritesLocalDataSource);
  });

  group('FavoriteRepositoryImpl getAll method', () {
    const List<String> favoriteIdsList = ['999', '2'];

    test('should return list of String when retrieving favorites from local storage', () async {
      when(mockFavoritesLocalDataSource.getAll()).thenAnswer((_) => favoriteIdsList);

      final sut = await favoritesRepositoryImpl.getAll();

      expect(sut, const Right(favoriteIdsList));
      verify(mockFavoritesLocalDataSource.getAll());
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });

    test('should return AppError when fails to retrieve favorites from local storage', () async {
      when(mockFavoritesLocalDataSource.getAll()).thenThrow(const AppError(properties: []));

      final sut = await favoritesRepositoryImpl.getAll();

      expect(sut, const Left(AppError(properties: [])));
      verify(mockFavoritesLocalDataSource.getAll());
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });
  });

  group('FavoriteRepositoryImpl update method', () {
    final characterId = Faux.character.id;

    test('should return true when characterId is successfully persisted locally', () async {
      when(mockFavoritesLocalDataSource.update(characterId: characterId)).thenAnswer((_) async => true);

      final sut = await favoritesRepositoryImpl.update(characterId: characterId);

      expect(sut, const Right(true));
      verify(mockFavoritesLocalDataSource.update(characterId: characterId));
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });

    test('should return AppError when fails to persist characterId locally', () async {
      when(mockFavoritesLocalDataSource.update(characterId: characterId)).thenThrow(const AppError(properties: []));

      final sut = await favoritesRepositoryImpl.update(characterId: characterId);

      expect(sut, const Left(AppError(properties: [])));
      verify(mockFavoritesLocalDataSource.update(characterId: characterId));
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });
  });
}
