import 'package:dartz/dartz.dart';

import '../../../error/error.dart';
import '../../data/models/models.dart';
import '../entities/entities.dart';

abstract class FavoritesRepository {
  Future<Either<AppError, List<String>>> getIds();
  Future<Either<AppError, List<FavoriteCharacter>>> getFavoriteCharacters(
      {required List<String> charactersIds});
  Future<Either<AppError, UpdatedFavorite>> update(
      {required String characterId});
  Stream<UpdatedFavorite> get updatedFavorites;
}
