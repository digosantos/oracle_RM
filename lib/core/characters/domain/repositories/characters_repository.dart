import 'package:dartz/dartz.dart';

import '../../../error/error.dart';
import '../entities/entities.dart';

abstract class CharactersRepository {
  Future<Either<AppError, List<Character>>> getAllCharacters();
  Future<Either<AppError, Character>> getCharacterDetails({required int id});
}
