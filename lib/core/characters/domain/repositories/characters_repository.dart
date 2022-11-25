import 'package:dartz/dartz.dart';

import '../../../../features/characters_listing/domain/usecases/usecases.dart';
import '../../../error/error.dart';
import '../entities/entities.dart';

abstract class CharactersRepository {
  Future<Either<AppError, FavoriteCharactersResponse>> getAllCharacters({required int pageNumber, Filter? filter});
  Future<Either<AppError, List<Character>>> getCharactersList({required List<String> characterIdList});
  Future<Either<AppError, CharacterDetails>> getCharacterDetails({
    required String id,
    required List<String> episodesIds,
  });
}
