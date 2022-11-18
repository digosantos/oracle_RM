import 'package:dartz/dartz.dart';

import '../../../error/error.dart';

abstract class FavoritesRepository {
  Future<Either<AppError, bool>> save();
  Future<Either<AppError, bool>> remove();
}
