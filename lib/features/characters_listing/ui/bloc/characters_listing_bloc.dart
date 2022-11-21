import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

import '../../../../core/characters/domain/entities/entities.dart';

class CharactersListingBloc extends Bloc<CharactersListingEvent, CharactersListingState> {
  final UseCase<CharactersResponse, int> getAllCharactersUseCase;

  int page = 0;
  List<int> loadedPages = [];
  List<Character> charactersList = [];

  CharactersListingBloc({required this.getAllCharactersUseCase}) : super(CharactersListInitialState()) {
    on<GetAllCharactersEvent>(_loadCharacters);
    on<CharacterCardTappedEvent>(_redirectToCharacterDetails);
  }

  /// Callbacks
  void _loadCharacters(GetAllCharactersEvent event, Emitter emit) async {
    page++;

    if (loadedPages.contains(page)) return;

    emit(CharactersListLoadingState());
    loadedPages.add(page);

    final response = await getAllCharactersUseCase(page);
    emit(response.fold(
      (failure) => CharactersListErrorState(
        failure: AppError(properties: failure.properties),
      ),
      (charactersResponse) {
        if (charactersResponse.nextPage != null) page = charactersResponse.nextPage!;
        charactersList.addAll(charactersResponse.charactersList);
        return CharactersListLoadedState(charactersList: charactersList);
      },
    ));
  }

  void _redirectToCharacterDetails(CharacterCardTappedEvent event, Emitter emit) {
    emit(RedirectToCharacterDetailsState(character: event.character));
  }
}
