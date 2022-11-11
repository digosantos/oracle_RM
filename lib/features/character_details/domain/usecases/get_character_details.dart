import 'package:dartz/dartz.dart';

import '../../../../core/characters/domain/entities/entities.dart';
import '../../../../core/characters/domain/repositories/repositories.dart';
import '../../../../core/error/error.dart';

class GetCharacterDetails {
  final CharactersRepository charactersRepository;

  GetCharacterDetails({required this.charactersRepository});

  Future<Either<AppError, Character>> execute({required int characterId}) async {
    return await charactersRepository.getCharacterDetails(id: characterId);
  }
}
