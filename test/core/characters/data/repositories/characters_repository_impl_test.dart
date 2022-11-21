import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/characters/data/repositories/repositories.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/core/error/error.dart';

import '../../../../utils/faux.dart';
import '../datasources/characters_remote_datasource_test.mocks.dart';

void main() {
  late MockCharactersRemoteDataSource mockCharactersRemoteDataSource;
  late CharactersRepositoryImpl charactersRepositoryImpl;

  setUp(() {
    mockCharactersRemoteDataSource = MockCharactersRemoteDataSource();
    charactersRepositoryImpl = CharactersRepositoryImpl(
        charactersRemoteDataSource: mockCharactersRemoteDataSource);
  });

  group('Get all characters repository implementation', () {
    const charactersResponseModel = Faux.charactersResponseModel;
    const CharactersResponse charactersResponse = charactersResponseModel;
    const page = 1;

    test('should return CharactersResponse', () async {
      when(mockCharactersRemoteDataSource.getAllCharacters(pageNumber: page))
          .thenAnswer((_) async => charactersResponseModel);

      final sut =
          await charactersRepositoryImpl.getAllCharacters(pageNumber: page);

      expect(sut, const Right(charactersResponse));
    });

    test('should return AppError', () async {
      when(mockCharactersRemoteDataSource.getAllCharacters(pageNumber: page))
          .thenThrow(ServerException());

      final sut =
          await charactersRepositoryImpl.getAllCharacters(pageNumber: page);

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
