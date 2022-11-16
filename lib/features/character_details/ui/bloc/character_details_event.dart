import 'package:equatable/equatable.dart';
import 'package:oracle_rm/features/character_details/domain/usecases/get_character_details.dart';

abstract class CharacterDetailsEvent extends Equatable {
  const CharacterDetailsEvent();

  @override
  List<Object?> get props => [];
}

class GetCharacterDetailsEvent extends CharacterDetailsEvent {
  final RequestedCharacter requestedCharacter;

  const GetCharacterDetailsEvent({required this.requestedCharacter});

  @override
  List<Object?> get props => [requestedCharacter];
}
