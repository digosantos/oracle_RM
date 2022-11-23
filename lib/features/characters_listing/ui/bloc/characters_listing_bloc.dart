import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

import '../../../../core/favorites/domain/entities/entities.dart';

class CharactersListingBloc extends Bloc<CharactersListingEvent, CharactersListingState> {
  final UseCase<FavoriteCharactersResponse, int> getAllCharactersUseCase;

  int? page = 1;
  List<FavoriteCharacter> charactersList = [];

  CharactersListingBloc({required this.getAllCharactersUseCase}) : super(CharactersListInitialState()) {
    on<GetAllCharactersEvent>(_loadCharacters);
    on<CharacterCardTappedEvent>(_redirectToCharacterDetails);
  }

  /// Callbacks
  void _loadCharacters(GetAllCharactersEvent event, Emitter emit) async {
    if (page == null) return;

    final response = await getAllCharactersUseCase(page!);
    emit(response.fold(
      (failure) => CharactersListErrorState(
        failure: AppError(properties: failure.properties),
      ),
      (allCharactersResponse) {
        page = allCharactersResponse.nextPage;

        charactersList = List.of(charactersList)..addAll(allCharactersResponse.charactersList);

        final listLength = (allCharactersResponse.nextPage != null) ? charactersList.length + 1 : charactersList.length;

        return CharactersListLoadedState(charactersList: charactersList, listLength: listLength);
      },
    ));
  }

  void _redirectToCharacterDetails(CharacterCardTappedEvent event, Emitter emit) {
    emit(RedirectToCharacterDetailsState(characterToDiplay: event.character));
  }
}
