import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/favorites/domain/entities/entities.dart';
import 'package:oracle_rm/features/character_details/domain/usecases/get_character_details.dart';

abstract class CharacterDetailsEvent extends Equatable {
  const CharacterDetailsEvent();

  @override
  List<Object?> get props => [];
}

class GetCharacterDetailsEvent extends CharacterDetailsEvent {
  final RequestedCharacterParam requestedCharacter;

  const GetCharacterDetailsEvent({required this.requestedCharacter});

  @override
  List<Object?> get props => [requestedCharacter];
}

class FavoriteCharacterDetailsTappedEvent extends CharacterDetailsEvent {
  final FavoriteCharacter favoriteCharacter;

  const FavoriteCharacterDetailsTappedEvent({required this.favoriteCharacter});

  @override
  List<Object?> get props => [favoriteCharacter];
}
