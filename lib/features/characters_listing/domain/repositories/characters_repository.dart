import 'package:dartz/dartz.dart';

import '../entities/entities.dart';

abstract class CharactersRepository {
  Future<Either<Error, List<Character>>> getAllCharacters();
}
