import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/error/failures.dart';
import 'package:oracle_rm/core/favorites/domain/repositories/repositories.dart';

import '../datasources/datasources.dart';

class UpdatedFavorite {
  final String characterId;
  final bool isFavorite;

  UpdatedFavorite({required this.characterId, required this.isFavorite});
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource favoritesLocalDataSource;
  final StreamController<UpdatedFavorite> _streamController = StreamController.broadcast();

  FavoritesRepositoryImpl({required this.favoritesLocalDataSource});

  @override
  Stream<UpdatedFavorite> get updatedFavorites => _streamController.stream;

  @override
  Future<Either<AppError, List<String>>> getAll() async {
    try {
      return Right(favoritesLocalDataSource.getAll());
    } on AppError {
      return const Left(AppError(properties: []));
    }
  }

  @override
  Future<Either<AppError, UpdatedFavorite>> update({required String characterId}) async {
    try {
      final updatedFavorite = await favoritesLocalDataSource.update(characterId: characterId);
      _streamController.add(updatedFavorite);
      return Right(updatedFavorite);
    } on AppError {
      return const Left(AppError(properties: []));
    }
  }
}
