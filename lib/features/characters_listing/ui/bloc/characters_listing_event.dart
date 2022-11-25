import 'package:equatable/equatable.dart';

import '../../../../core/favorites/domain/entities/entities.dart';

abstract class CharactersListingEvent extends Equatable {
  const CharactersListingEvent();

  @override
  List<Object?> get props => [];
}

class SetupStreamEvent extends CharactersListingEvent {}

class GetAllCharactersEvent extends CharactersListingEvent {}

class CharacterCardTappedEvent extends CharactersListingEvent {
  final FavoriteCharacter favoriteCharacter;

  const CharacterCardTappedEvent({required this.favoriteCharacter});

  @override
  List<Object?> get props => [favoriteCharacter];
}

class FavoriteCharacterTappedEvent extends CharactersListingEvent {
  final FavoriteCharacter favoriteCharacter;

  const FavoriteCharacterTappedEvent({required this.favoriteCharacter});

  @override
  List<Object?> get props => [favoriteCharacter];
}

class FavoritesTappedEvent extends CharactersListingEvent {}
