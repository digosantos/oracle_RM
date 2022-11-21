import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/favorites/domain/repositories/repositories.dart';

import '../../../domain/usecases/usecase.dart';
import '../../../error/error.dart';

class GetFavoritesUseCase extends UseCase<List<String>, NoParams> {
  final FavoritesRepository favoritesRepository;

  GetFavoritesUseCase({required this.favoritesRepository});

  @override
  Future<Either<AppError, List<String>>> call(NoParams params) async {
    return favoritesRepository.getAll();
  }
}
