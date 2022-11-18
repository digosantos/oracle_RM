import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/failures.dart';

import '../repositories/repositories.dart';

class SaveFavorite extends UseCase<bool, String> {
  final FavoritesRepository favoritesRepository;

  SaveFavorite({required this.favoritesRepository});

  @override
  Future<Either<AppError, bool>> call(String params) async {
    return await favoritesRepository.save();
  }
}
