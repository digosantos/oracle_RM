import 'package:dartz/dartz.dart';

import '../../../../core/error/error.dart';
import '../entities/entities.dart';

abstract class CharactersRepository {
  Future<Either<Failure, List<Character>>> getAllCharacters();
}
