import 'package:dartz/dartz.dart';

import '../../../error/error.dart';

abstract class FavoritesRepository {
  Future<Either<AppError, List<String>>> getAll();
  Future<Either<AppError, bool>> save({required String characterId});
  Future<Either<AppError, bool>> remove({required String characterId});
}
