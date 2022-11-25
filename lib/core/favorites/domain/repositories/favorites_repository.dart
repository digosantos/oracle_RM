import 'package:dartz/dartz.dart';

import '../../../error/error.dart';
import '../../data/models/models.dart';

abstract class FavoritesRepository {
  Future<Either<AppError, List<String>>> getAll();
  Future<Either<AppError, UpdatedFavorite>> update({required String characterId});
  Stream<UpdatedFavorite> get updatedFavorites;
}
