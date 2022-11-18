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

  group('FavoriteRepositoryImpl save method', () {
    final characterId = Faux.character.id;

    test('should return true when characterId is successfully persisted locally', () async {
      when(mockFavoritesLocalDataSource.save(characterId: characterId)).thenAnswer((_) async => true);

      final sut = await favoritesRepositoryImpl.save(characterId: characterId);

      expect(sut, const Right(true));
      verify(mockFavoritesLocalDataSource.save(characterId: characterId));
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });

    test('should return AppError when fails to persist characterId locally', () async {
      when(mockFavoritesLocalDataSource.save(characterId: characterId)).thenThrow(const AppError(properties: []));

      final sut = await favoritesRepositoryImpl.save(characterId: characterId);

      expect(sut, const Left(AppError(properties: [])));
      verify(mockFavoritesLocalDataSource.save(characterId: characterId));
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });
  });

  group('FavoriteRepositoryImpl remove method', () {
    final characterId = Faux.character.id;

    test('should return true when characterId is successfully removed from local storage', () async {
      when(mockFavoritesLocalDataSource.remove(characterId: characterId)).thenAnswer((_) async => true);

      final sut = await favoritesRepositoryImpl.remove(characterId: characterId);

      expect(sut, const Right(true));
      verify(mockFavoritesLocalDataSource.remove(characterId: characterId));
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });

    test('should return AppError when fails to remove characterId from local storage', () async {
      when(mockFavoritesLocalDataSource.remove(characterId: characterId)).thenThrow(const AppError(properties: []));

      final sut = await favoritesRepositoryImpl.remove(characterId: characterId);

      expect(sut, const Left(AppError(properties: [])));
      verify(mockFavoritesLocalDataSource.remove(characterId: characterId));
      verifyNoMoreInteractions(mockFavoritesLocalDataSource);
    });
  });
}
