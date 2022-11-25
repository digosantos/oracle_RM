import 'package:dartz/dartz.dart';

import '../../../error/error.dart';
import '../entities/entities.dart';

abstract class CharactersRepository {
  Future<Either<AppError, FavoriteCharactersResponse>> getAllCharacters({required int pageNumber});
  Future<Either<AppError, List<Character>>> getCharactersList({required List<String> characterIdList});
  Future<Either<AppError, CharacterDetails>> getCharacterDetails({
    required String id,
    required List<String> episodesIds,
  });
}
