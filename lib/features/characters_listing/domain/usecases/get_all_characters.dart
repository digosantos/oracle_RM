import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/characters_listing/domain/entities/character.dart';
import 'package:oracle_rm/features/characters_listing/domain/repositories/characters_repository.dart';

class GetAllCharacters {
  final CharactersRepository charactersRepository;

  GetAllCharacters({required this.charactersRepository});

  Future<Either<AppError, List<Character>>> execute() async {
    return await charactersRepository.getAllCharacters();
  }
}
