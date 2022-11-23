import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/characters/data/datasources/characters_remote_datasource.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/core/favorites/data/datasources/datasources.dart';

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
  Future<Either<AppError, FavoriteCharactersResponse>> getAllCharacters({required int pageNumber}) async {
    try {
      final charactersResponse = await charactersRemoteDataSource.getAllCharacters(pageNumber: pageNumber);
      final favoriteCharactersIds = favoritesLocalDataSource.getAll();

      List<FavoriteCharacter> charactersToDisplay = [];

      for (var character in charactersResponse.charactersList) {
        if (favoriteCharactersIds.contains(character.id)) {
          charactersToDisplay.add(
            FavoriteCharacter(character: character, isFavorite: true),
          );

          /// Optimize amount of iterations
          favoriteCharactersIds.remove(character.id);
        } else {
          charactersToDisplay.add(
            FavoriteCharacter(character: character, isFavorite: false),
          );
        }
      }

      return Right(FavoriteCharactersResponse(
        nextPage: charactersResponse.nextPage,
        charactersList: charactersToDisplay,
      ));
    } on ServerException {
      return const Left(AppError(properties: []));
    }
  }

  @override
  Future<Either<AppError, CharacterDetails>> getCharacterDetails({required String id, required List<String> episodesIds}) async {
    try {
      final characterDetails = await charactersRemoteDataSource.getCharacterDetails(id: id, episodesIds: episodesIds);
      return Right(characterDetails);
    } on ServerException {
      return const Left(AppError(properties: []));
    }
  }
}
