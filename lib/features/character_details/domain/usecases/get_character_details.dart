import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';

import '../../../../core/characters/domain/entities/entities.dart';
import '../../../../core/characters/domain/repositories/repositories.dart';
import '../../../../core/error/error.dart';

class GetCharacterDetails extends UseCase<Character, RequestedCharacterParam> {
  final CharactersRepository charactersRepository;

  GetCharacterDetails({required this.charactersRepository});

  @override
  Future<Either<AppError, Character>> call(RequestedCharacterParam params) async {
    return await charactersRepository.getCharacterDetails(
      id: params.id,
      episodesIds: params.episodesIds,
    );
  }
}

class RequestedCharacterParam extends Equatable {
  final String id;
  final List<String> episodesIds;

  const RequestedCharacterParam({required this.id, required this.episodesIds});

  @override
  List<Object?> get props => [id, episodesIds];
}
