import 'package:dartz/dartz.dart';

import '../../../domain/usecases/usecase.dart';
import '../../../error/error.dart';
import '../../data/models/models.dart';
import '../repositories/repositories.dart';

class ObserveUpdatedFavorites extends UseCase<Stream<UpdatedFavorite>, NoParams> {
  final FavoritesRepository favoritesRepository;

  ObserveUpdatedFavorites({required this.favoritesRepository});

  @override
  Either<AppError, Stream<UpdatedFavorite>> call(NoParams params) {
    return Right(favoritesRepository.updatedFavorites);
  }
}
