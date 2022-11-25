import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/favorites/domain/entities/entities.dart';

import '../../../../core/characters/domain/entities/entities.dart';
import '../../../../core/characters/domain/repositories/repositories.dart';
import '../../../../core/error/error.dart';

class GetCharacterDetails extends UseCase<CharacterDetails, RequestedCharacterParam> {
  final CharactersRepository charactersRepository;

  GetCharacterDetails({required this.charactersRepository});

  @override
  Future<Either<AppError, CharacterDetails>> call(RequestedCharacterParam params) async {
    return await charactersRepository.getCharacterDetails(
      id: params.favoriteCharacter.character.id,
      episodesIds: params.episodesIds,
    );
  }
}

class RequestedCharacterParam extends Equatable {
  final FavoriteCharacter favoriteCharacter;
  final List<String> episodesIds;

  const RequestedCharacterParam({required this.favoriteCharacter, required this.episodesIds});

  @override
  List<Object?> get props => [favoriteCharacter, episodesIds];
}
