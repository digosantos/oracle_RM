import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/characters/data/datasources/characters_remote_datasource.dart';
import 'package:oracle_rm/core/error/error.dart';

import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDataSource charactersRemoteDataSource;

  CharactersRepositoryImpl({required this.charactersRemoteDataSource});

  @override
  Future<Either<AppError, CharactersResponse>> getAllCharacters(
      {required int pageNumber}) async {
    try {
      final charactersResponse = await charactersRemoteDataSource
          .getAllCharacters(pageNumber: pageNumber);
      return Right(charactersResponse);
    } on ServerException {
      return const Left(AppError(properties: []));
    }
  }

  @override
  Future<Either<AppError, CharacterDetails>> getCharacterDetails(
      {required String id, required List<String> episodesIds}) async {
    try {
      final characterDetails = await charactersRemoteDataSource
          .getCharacterDetails(id: id, episodesIds: episodesIds);
      return Right(characterDetails);
    } on ServerException {
      return const Left(AppError(properties: []));
    }
  }
}
