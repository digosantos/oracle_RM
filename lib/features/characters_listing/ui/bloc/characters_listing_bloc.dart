import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

import '../../../../core/favorites/data/repositories/favorites_repository_impl.dart';
import '../../../../core/favorites/domain/entities/entities.dart';

class CharactersListingBloc extends Bloc<CharactersListingEvent, CharactersListingState> {
  final UseCase<FavoriteCharactersResponse, int> getAllCharactersUseCase;
  final UseCase<UpdatedFavorite, String> updateFavoriteUseCase;
  final UseCase<Stream<UpdatedFavorite>, NoParams> observeUpdatedFavoritesUseCase;

  int? page = 1;
  List<FavoriteCharacter> charactersList = [];

  CharactersListingBloc({
    required this.getAllCharactersUseCase,
    required this.updateFavoriteUseCase,
    required this.observeUpdatedFavoritesUseCase,
  }) : super(CharactersListInitialState()) {
    on<SetupStreamEvent>(_setupStream);
    on<GetAllCharactersEvent>(_loadCharacters);
    on<CharacterCardTappedEvent>(_redirectToCharacterDetails);
    on<FavoriteCharacterTappedEvent>(_favoriteCharacter);

    add(SetupStreamEvent());
  }

  /// Callbacks
  void _setupStream(SetupStreamEvent event, Emitter emit) async {
    final result = await observeUpdatedFavoritesUseCase(NoParams());

    await result.fold((failure) async => null, (updatedFavorite) async {
      await emit.forEach(updatedFavorite, onData: (updatedFavorite) {
        final indexToUpdate = charactersList.indexWhere(
          (favoriteCharacter) => favoriteCharacter.character.id == updatedFavorite.characterId,
        );

        if (indexToUpdate == -1) return state;

        final favoriteCharacter = charactersList[indexToUpdate];

        /// Creates a deep copy of previous list in order to differ states
        final updatedList = <FavoriteCharacter>[...charactersList];

        updatedList[indexToUpdate] = FavoriteCharacter(
          character: favoriteCharacter.character,
          isFavorite: updatedFavorite.isFavorite,
        );

        charactersList = updatedList;

        final listLength = (page != null) ? charactersList.length + 1 : charactersList.length;
        return CharactersListLoadedState(charactersList: charactersList, listLength: listLength);
      });
    });
  }

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

        final listLength = (page != null) ? charactersList.length + 1 : charactersList.length;

        return CharactersListLoadedState(charactersList: charactersList, listLength: listLength);
      },
    ));
  }

  void _redirectToCharacterDetails(CharacterCardTappedEvent event, Emitter emit) {
    emit(RedirectToCharacterDetailsState(
      favoriteCharacter: event.favoriteCharacter,
      shouldRebuild: !state.shouldRebuild,
    ));
  }

  void _favoriteCharacter(FavoriteCharacterTappedEvent event, Emitter emit) async {
    final favoriteCharacterId = event.favoriteCharacter.character.id;
    final isUpdateSuccessful = await updateFavoriteUseCase(favoriteCharacterId);

    emit(isUpdateSuccessful.fold(
      (failure) => CharactersListErrorState(
        failure: AppError(properties: failure.properties),
      ),
      (updatedFavorite) {
        final indexToUpdate = charactersList.indexWhere((favoriteCharacter) => favoriteCharacter.character.id == favoriteCharacterId);

        final updatedFavoriteCharacter = FavoriteCharacter.update(favoriteCharacter: charactersList[indexToUpdate]);

        /// Creates a deep copy of previous list in order to differ states
        final updatedList = <FavoriteCharacter>[...charactersList];
        updatedList.removeAt(indexToUpdate);
        updatedList.insert(indexToUpdate, updatedFavoriteCharacter);

        charactersList = updatedList;

        final listLength = (page != null) ? charactersList.length + 1 : charactersList.length;
        return CharactersListLoadedState(charactersList: charactersList, listLength: listLength);
      },
    ));
  }
}
