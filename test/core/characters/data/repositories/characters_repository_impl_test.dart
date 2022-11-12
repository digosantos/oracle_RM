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
    final charactersModelList = [Faux.characterModel, Faux.characterModel];
    final List<Character> charactersList = charactersModelList;

    test('should return a list with all characters', () async {
      when(mockCharactersRemoteDataSource.getAllCharacters())
          .thenAnswer((_) async => charactersModelList);

      final sut = await charactersRepositoryImpl.getAllCharacters();

      expect(sut, Right(charactersList));
    });

    test('should return AppError', () async {
      when(mockCharactersRemoteDataSource.getAllCharacters())
          .thenThrow(ServerException());

      final sut = await charactersRepositoryImpl.getAllCharacters();

      expect(sut, const Left(AppError(properties: [])));
    });
  });
}
