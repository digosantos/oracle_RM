import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/characters/data/datasources/characters_remote_datasource.dart';
import 'package:oracle_rm/core/error/error.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDataSource charactersRemoteDataSource;

  CharactersRepositoryImpl({required this.charactersRemoteDataSource});

  @override
  Future<Either<AppError, List<Character>>> getAllCharacters() async {
    try {
      final charactersList =
          await charactersRemoteDataSource.getAllCharacters();
      return Right(charactersList);
    } on ServerException {
      return const Left(AppError(properties: []));
    }
  }

  @override
  Future<Either<AppError, Character>> getCharacterDetails(
      {required String id}) async {
    try {
      final character =
          await charactersRemoteDataSource.getCharacterDetails(id: id);
      return Right(character);
    } on ServerException {
      return const Left(AppError(properties: []));
    }
  }
}
