import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/characters/domain/entities/entities.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/error.dart';
import '../../../../core/favorites/data/models/models.dart';
import '../../../../core/favorites/domain/entities/entities.dart';
import '../../../characters_listing/domain/usecases/usecases.dart';
import './bloc.dart';

class CharacterDetailsBloc extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final UseCase<CharacterDetails, RequestedCharacterParam> getCharacterDetailsUseCase;
  final UseCase<UpdatedFavorite, String> updateFavoriteUseCase;

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
    final updatedFavoriteResult = await updateFavoriteUseCase(favoriteCharacterId);

    emit(
      updatedFavoriteResult.fold(
        (failure) => ErrorState(
          failure: AppError(properties: failure.properties),
        ),
        (updatedFavorite) {
          final updatedFavoriteCharacter = FavoriteCharacter.update(
            favoriteCharacter: event.favoriteCharacter,
          );

          return DetailsLoadedState(
            characterDetails: characterDetails,
            favoriteCharacter: updatedFavoriteCharacter,
          );
        },
      ),
    );
  }
}
