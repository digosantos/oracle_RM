import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/characters/data/datasources/characters_remote_datasource.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/core/favorites/data/datasources/datasources.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/get_all_characters.dart';

import '../../../favorites/domain/entities/entities.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersRemoteDataSource charactersRemoteDataSource;
  final FavoritesLocalDataSource favoritesLocalDataSource;

  CharactersRepositoryImpl({
    required this.charactersRemoteDataSource,
    required this.favoritesLocalDataSource,
  });

  @override
  Future<Either<AppError, FavoriteCharactersResponse>> getAllCharacters(
      {required int pageNumber, Filter? filter}) async {
    try {
      final charactersResponse = await charactersRemoteDataSource
          .getAllCharacters(pageNumber: pageNumber, filter: filter);
      final favoriteCharactersIds = favoritesLocalDataSource.getAll();

      List<FavoriteCharacter> favoriteCharacters = [];

      for (var character in charactersResponse.charactersList) {
        if (favoriteCharactersIds.contains(character.id)) {
          favoriteCharacters.add(
            FavoriteCharacter(character: character, isFavorite: true),
          );

          /// Optimize amount of iterations
          favoriteCharactersIds.remove(character.id);
        } else {
          favoriteCharacters.add(
            FavoriteCharacter(character: character, isFavorite: false),
          );
        }
      }

      return Right(FavoriteCharactersResponse(
        nextPage: charactersResponse.nextPage,
        charactersList: favoriteCharacters,
      ));
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

  @override
  Future<Either<AppError, List<Character>>> getCharactersList(
      {required List<String> characterIdList}) async {
    try {
      final charactersList = await charactersRemoteDataSource.getCharactersList(
          characterIdList: characterIdList);
      return Right(charactersList);
    } on ServerException {
      return const Left(AppError(properties: []));
    }
  }
}
