import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/error/error.dart';

import '../../../../core/characters/domain/entities/entities.dart';
import '../../../../core/characters/domain/repositories/repositories.dart';

class GetAllCharacters {
  final CharactersRepository charactersRepository;

  GetAllCharacters({required this.charactersRepository});

  Future<Either<AppError, List<Character>>> call() async {
    return await charactersRepository.getAllCharacters();
  }
}
