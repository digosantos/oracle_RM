import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/failures.dart';

import '../../data/models/models.dart';
import '../repositories/repositories.dart';

class UpdateFavorite extends UseCase<UpdatedFavorite, String> {
  final FavoritesRepository favoritesRepository;

  UpdateFavorite({required this.favoritesRepository});

  @override
  Future<Either<AppError, UpdatedFavorite>> call(String params) async {
    return await favoritesRepository.update(characterId: params);
  }
}
