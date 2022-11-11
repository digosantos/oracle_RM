import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';

import '../../../../core/characters/domain/entities/entities.dart';
import '../../../../core/characters/domain/repositories/repositories.dart';
import '../../../../core/error/error.dart';

class GetCharacterDetails extends UseCase<Character, RequestedCharacter> {
  final CharactersRepository charactersRepository;

  GetCharacterDetails({required this.charactersRepository});

  @override
  Future<Either<AppError, Character>> call(RequestedCharacter params) async {
    return await charactersRepository.getCharacterDetails(id: params.id);
  }
}

class RequestedCharacter extends Equatable {
  final int id;

  const RequestedCharacter({required this.id});

  @override
  List<Object?> get props => [id];
}
