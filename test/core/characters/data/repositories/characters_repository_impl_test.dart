import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/characters/data/repositories/repositories.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/core/error/error.dart';

import '../../../../utils/faux.dart';
import '../../../favorites/data/datasources/favorites_local_datasource_test.mocks.dart';
import '../datasources/characters_remote_datasource_test.mocks.dart';

void main() {
  late MockCharactersRemoteDataSource mockCharactersRemoteDataSource;
  late MockFavoritesLocalDataSource mockFavoritesLocalDataSource;
  late CharactersRepositoryImpl charactersRepositoryImpl;

  setUp(() {
    mockCharactersRemoteDataSource = MockCharactersRemoteDataSource();
    mockFavoritesLocalDataSource = MockFavoritesLocalDataSource();
    charactersRepositoryImpl = CharactersRepositoryImpl(
      charactersRemoteDataSource: mockCharactersRemoteDataSource,
      favoritesLocalDataSource: mockFavoritesLocalDataSource,
    );
  });

  group('Get all characters repository implementation', () {
    const FavoriteCharactersResponse favoriteCharactersResponse = FavoriteCharactersResponse(
      nextPage: 2,
      charactersList: [Faux.favoriteCharacter],
    );
    const page = 1;

    test('should return FavoriteCharactersResponse', () async {
      when(mockCharactersRemoteDataSource.getAllCharacters(pageNumber: page)).thenAnswer((_) async => Faux.charactersResponseModel);
      when(mockFavoritesLocalDataSource.getAll()).thenAnswer((_) => ['999']);

      final sut = await charactersRepositoryImpl.getAllCharacters(pageNumber: page);

      expect(sut, const Right(favoriteCharactersResponse));
    });

    test('should return AppError', () async {
      when(mockCharactersRemoteDataSource.getAllCharacters(pageNumber: page)).thenThrow(ServerException());
      when(mockFavoritesLocalDataSource.getAll()).thenAnswer((_) => []);

      final sut = await charactersRepositoryImpl.getAllCharacters(pageNumber: page);

      expect(sut, const Left(AppError(properties: [])));
    });
  });

  group('Get character details repository implementation', () {
    const characterDetailsModel = Faux.characterDetailsModel;
    const Character character = characterDetailsModel;
    const episodesIds = Faux.episodesIds;

    test('should return character with its details', () async {
      when(mockCharactersRemoteDataSource.getCharacterDetails(
        id: characterDetailsModel.id,
        episodesIds: episodesIds,
      )).thenAnswer((_) async => characterDetailsModel);

      final sut = await charactersRepositoryImpl.getCharacterDetails(
        id: characterDetailsModel.id,
        episodesIds: episodesIds,
      );

      expect(sut, const Right(character));
    });

    test('should return AppError', () async {
      when(mockCharactersRemoteDataSource.getCharacterDetails(
        id: character.id,
        episodesIds: episodesIds,
      )).thenThrow(ServerException());

      final sut = await charactersRepositoryImpl.getCharacterDetails(
        id: character.id,
        episodesIds: episodesIds,
      );

      expect(sut, const Left(AppError(properties: [])));
    });
  });
}
