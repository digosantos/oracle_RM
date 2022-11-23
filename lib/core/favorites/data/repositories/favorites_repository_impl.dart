import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/error/failures.dart';
import 'package:oracle_rm/core/favorites/domain/repositories/repositories.dart';

import '../datasources/datasources.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource favoritesLocalDataSource;

  FavoritesRepositoryImpl({required this.favoritesLocalDataSource});

  @override
  Future<Either<AppError, List<String>>> getAll() async {
    try {
      return Right(favoritesLocalDataSource.getAll());
    } on AppError {
      return const Left(AppError(properties: []));
    }
  }

  @override
  Future<Either<AppError, bool>> update({required String characterId}) async {
    try {
      return Right(await favoritesLocalDataSource.update(characterId: characterId));
    } on AppError {
      return const Left(AppError(properties: []));
    }
  }
}
