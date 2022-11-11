import 'package:dartz/dartz.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/error.dart';

import '../../../../core/characters/domain/entities/entities.dart';
import '../../../../core/characters/domain/repositories/repositories.dart';

class GetAllCharacters extends UseCase<List<Character>, NoParams> {
  final CharactersRepository charactersRepository;

  GetAllCharacters({required this.charactersRepository});

  @override
  Future<Either<AppError, List<Character>>> call(NoParams params) async {
    return await charactersRepository.getAllCharacters();
  }
}
