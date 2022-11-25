import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/error/error.dart';

import '../../../../core/favorites/domain/entities/entities.dart';

abstract class CharactersListingState extends Equatable {
  final bool shouldRebuild;

  const CharactersListingState({this.shouldRebuild = false});

  @override
  List<Object?> get props => [shouldRebuild];
}

class CharactersListInitialState extends CharactersListingState {}

class CharactersListLoadingState extends CharactersListingState {}

class CharactersListLoadedState extends CharactersListingState {
  final List<FavoriteCharacter> charactersList;
  final int listLength;

  const CharactersListLoadedState({required this.charactersList, required this.listLength});

  @override
  List<Object?> get props => [charactersList, listLength];
}

class CharactersListErrorState extends CharactersListingState {
  final Failure failure;

  const CharactersListErrorState({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class RedirectToCharacterDetailsState extends CharactersListingState {
  final FavoriteCharacter favoriteCharacter;

  const RedirectToCharacterDetailsState({
    required this.favoriteCharacter,
    required super.shouldRebuild,
  });

  @override
  List<Object?> get props => [favoriteCharacter, shouldRebuild];
}
