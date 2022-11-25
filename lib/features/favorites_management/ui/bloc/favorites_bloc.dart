import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/error.dart';
import '../../../../core/favorites/data/models/models.dart';
import '../../../../core/favorites/domain/entities/entities.dart';
import './bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final UseCase<List<FavoriteCharacter>, NoParams> getFavoriteCharactersUseCase;
  final UseCase<UpdatedFavorite, String> updateFavoriteUseCase;
  final UseCase<Stream<UpdatedFavorite>, NoParams> observeUpdatedFavoritesUseCase;

  List<FavoriteCharacter> charactersList = [];

  FavoritesBloc({
    required this.getFavoriteCharactersUseCase,
    required this.updateFavoriteUseCase,
    required this.observeUpdatedFavoritesUseCase,
  }) : super(FavoritesInitialState()) {
    on<SetupFavoritesStreamEvent>(_setupStream);
    on<GetFavoriteCharactersEvent>(_loadCharacters);
    on<FavoriteTappedEvent>(_favoriteCharacter);

    add(SetupFavoritesStreamEvent());
  }

  /// Callbacks
  void _setupStream(SetupFavoritesStreamEvent event, Emitter emit) async {
    final result = await observeUpdatedFavoritesUseCase(NoParams());

    await result.fold((failure) async => null, (updatedFavorite) async {
      await emit.forEach(updatedFavorite, onData: (updatedFavorite) {
        final indexToUpdate = charactersList.indexWhere(
          (favoriteCharacter) => favoriteCharacter.character.id == updatedFavorite.characterId,
        );

        if (indexToUpdate == -1) return state;

        /// Creates a deep copy of previous list in order to differ states
        final updatedList = <FavoriteCharacter>[...charactersList];
        updatedList.removeAt(indexToUpdate);

        charactersList = updatedList;

        return FavoritesListLoadedState(charactersList: charactersList);
      });
    });
  }

  void _loadCharacters(GetFavoriteCharactersEvent event, Emitter emit) async {
    final response = await getFavoriteCharactersUseCase(NoParams());
    emit(response.fold(
      (failure) => FavoritesListErrorState(
        failure: AppError(properties: failure.properties),
      ),
      (favoriteCharacters) {
        charactersList = List.of(charactersList)..addAll(favoriteCharacters);
        return FavoritesListLoadedState(charactersList: charactersList);
      },
    ));
  }

  void _favoriteCharacter(FavoriteTappedEvent event, Emitter emit) async {
    final updatedFavoriteResult = await updateFavoriteUseCase(event.favoriteCharacter.character.id);

    emit(
      updatedFavoriteResult.fold(
        (failure) => FavoritesListErrorState(
          failure: AppError(properties: failure.properties),
        ),
        (updatedFavorite) {
          return FavoritesListLoadedState(charactersList: charactersList);
        },
      ),
    );
  }
}
