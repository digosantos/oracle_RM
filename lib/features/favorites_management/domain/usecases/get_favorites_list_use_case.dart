import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';

import '../../../../core/error/error.dart';
import '../../../../core/favorites/domain/entities/entities.dart';
import '../../../../core/favorites/domain/repositories/repositories.dart';

class GetFavoritesListUseCase
    extends UseCase<List<FavoriteCharacter>, NoParams> {
  final FavoritesRepository favoritesRepository;

  GetFavoritesListUseCase({required this.favoritesRepository});

  @override
  Future<Either<AppError, List<FavoriteCharacter>>> call(params) async {
    final getIdsResult = await favoritesRepository.getIds();

    return getIdsResult.fold((failure) => const Left(AppError(properties: [])),
        (favoritesIds) async {
      final getFavoriteCharactersResult = await favoritesRepository
          .getFavoriteCharacters(charactersIds: favoritesIds);

      return getFavoriteCharactersResult
          .fold((failure) => const Left(AppError(properties: [])),
              (favoriteCharacters) {
        return Right(favoriteCharacters);
      });
    });
  }
}
