import 'package:equatable/equatable.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/get_all_characters.dart';

import '../../../../core/favorites/domain/entities/entities.dart';

abstract class CharactersListingEvent {
  const CharactersListingEvent();
}

class SetupStreamEvent extends CharactersListingEvent {}

class GetAllCharactersEvent extends CharactersListingEvent {
  final Filter? filter;

  const GetAllCharactersEvent({this.filter});
}

class CharacterCardTappedEvent extends CharactersListingEvent with EquatableMixin {
  final FavoriteCharacter favoriteCharacter;

  const CharacterCardTappedEvent({required this.favoriteCharacter});

  @override
  List<Object?> get props => [favoriteCharacter];
}

class FavoriteCharacterTappedEvent extends CharactersListingEvent with EquatableMixin {
  final FavoriteCharacter favoriteCharacter;

  const FavoriteCharacterTappedEvent({required this.favoriteCharacter});

  @override
  List<Object?> get props => [favoriteCharacter];
}

class FavoritesTappedEvent extends CharactersListingEvent {}
