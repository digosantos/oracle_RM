import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/error/error.dart';

import '../../../../core/favorites/domain/entities/entities.dart';

abstract class CharactersListingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CharactersListInitialState extends CharactersListingState {}

class CharactersListLoadingState extends CharactersListingState {}

class CharactersListLoadedState extends CharactersListingState {
  final List<FavoriteCharacter> charactersList;
  final int listLength;

  CharactersListLoadedState({required this.charactersList, required this.listLength});

  @override
  List<Object?> get props => [charactersList, listLength];
}

class CharactersListErrorState extends CharactersListingState {
  final Failure failure;

  CharactersListErrorState({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class RedirectToCharacterDetailsState extends CharactersListingState {
  final FavoriteCharacter characterToDiplay;

  RedirectToCharacterDetailsState({required this.characterToDiplay});

  @override
  List<Object?> get props => [characterToDiplay];
}
