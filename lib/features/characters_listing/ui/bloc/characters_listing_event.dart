import 'package:equatable/equatable.dart';

import '../../../../core/favorites/domain/entities/entities.dart';

abstract class CharactersListingEvent extends Equatable {
  const CharactersListingEvent();

  @override
  List<Object?> get props => [];
}

class GetAllCharactersEvent extends CharactersListingEvent {}

class CharacterCardTappedEvent extends CharactersListingEvent {
  final FavoriteCharacter character;

  const CharacterCardTappedEvent({required this.character});

  @override
  List<Object?> get props => [character];
}
