import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/character_details/ui/bloc/bloc.dart';

import '../../../../core/characters/domain/entities/entities.dart';
import '../../../../core/favorites/domain/entities/entities.dart';
import '../../../../core/injection_container.dart';
import '../../../characters_listing/domain/usecases/usecases.dart';
import '../../../characters_listing/ui/bloc/bloc.dart';

class CharacterDetailsBloc extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final UseCase<CharacterDetails, RequestedCharacterParam> getCharacterDetailsUseCase;
  final UseCase<bool, String> updateFavoriteUseCase;

  late CharacterDetails characterDetails;

  CharacterDetailsBloc({
    required this.getCharacterDetailsUseCase,
    required this.updateFavoriteUseCase,
  }) : super(InitialState()) {
    on<GetCharacterDetailsEvent>(_loadCharacterDetails);
    on<FavoriteCharacterDetailsTappedEvent>(_favoriteCharacter);
  }

  /// Callbacks
  void _loadCharacterDetails(GetCharacterDetailsEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await getCharacterDetailsUseCase(event.requestedCharacter);

    emit(response.fold(
      (failure) => ErrorState(
        failure: AppError(properties: failure.properties),
      ),
      (result) {
        characterDetails = result;
        return DetailsLoadedState(
          characterDetails: characterDetails,
          favoriteCharacter: event.requestedCharacter.favoriteCharacter,
        );
      },
    ));
  }

  void _favoriteCharacter(FavoriteCharacterDetailsTappedEvent event, Emitter emit) async {
    final favoriteCharacterId = event.favoriteCharacter.character.id;
    final isUpdateSuccessful = await updateFavoriteUseCase(favoriteCharacterId);

    emit(isUpdateSuccessful.fold(
      (failure) => ErrorState(
        failure: AppError(properties: failure.properties),
      ),
      (isSuccess) {
        if (isSuccess) {
          final updatedFavoriteCharacter = FavoriteCharacter.update(
            favoriteCharacter: event.favoriteCharacter,
          );

          sl<CharactersListingBloc>().add(
            FavoriteCharacterTappedEvent(favoriteCharacter: event.favoriteCharacter),
          );

          return DetailsLoadedState(
            characterDetails: characterDetails,
            favoriteCharacter: updatedFavoriteCharacter,
          );
        } else {
          return DetailsLoadedState(
            characterDetails: characterDetails,
            favoriteCharacter: event.favoriteCharacter,
          );
        }
      },
    ));
  }
}
