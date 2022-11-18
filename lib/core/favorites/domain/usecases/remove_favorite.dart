import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/failures.dart';
import 'package:oracle_rm/core/favorites/domain/repositories/favorites_repository.dart';

class RemoveFavorite extends UseCase<bool, String> {
  final FavoritesRepository favoritesRepository;

  RemoveFavorite({required this.favoritesRepository});

  @override
  Future<Either<AppError, bool>> call(String params) async {
    return await favoritesRepository.remove();
  }
}
