import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/characters/domain/repositories/characters_repository.dart';
import 'package:oracle_rm/core/error/failures.dart';
import 'package:oracle_rm/core/favorites/data/models/models.dart';
import 'package:oracle_rm/core/favorites/domain/entities/favorite_character.dart';
import 'package:oracle_rm/core/favorites/domain/repositories/repositories.dart';

import '../datasources/datasources.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource favoritesLocalDataSource;
  final CharactersRepository charactersRepository;
  final StreamController<UpdatedFavorite> _streamController =
      StreamController.broadcast();

  FavoritesRepositoryImpl({
    required this.favoritesLocalDataSource,
    required this.charactersRepository,
  });

  @override
  Stream<UpdatedFavorite> get updatedFavorites => _streamController.stream;

  @override
  Future<Either<AppError, List<String>>> getIds() async {
    try {
      return Right(favoritesLocalDataSource.getAll());
    } on AppError {
      return const Left(AppError(properties: []));
    }
  }

  @override
  Future<Either<AppError, UpdatedFavorite>> update(
      {required String characterId}) async {
    try {
      final updatedFavorite =
          await favoritesLocalDataSource.update(characterId: characterId);
      _streamController.add(updatedFavorite);
      return Right(updatedFavorite);
    } on AppError {
      return const Left(AppError(properties: []));
    }
  }

  @override
  Future<Either<AppError, List<FavoriteCharacter>>> getFavoriteCharacters(
      {required List<String> charactersIds}) async {
    try {
      final getCharactersListResult = await charactersRepository
          .getCharactersList(characterIdList: charactersIds);

      return getCharactersListResult.fold(
        (failure) => const Left(AppError(properties: [])),
        (charactersList) {
          return Right(List<FavoriteCharacter>.from(
            charactersList.map((character) =>
                FavoriteCharacter(character: character, isFavorite: true)),
          ));
        },
      );
    } on AppError {
      return const Left(AppError(properties: []));
    }
  }
}
