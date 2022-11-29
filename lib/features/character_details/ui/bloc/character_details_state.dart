import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/core/favorites/domain/entities/entities.dart';

abstract class CharacterDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends CharacterDetailsState {}

class LoadingState extends CharacterDetailsState {}

class DetailsLoadedState extends CharacterDetailsState {
  final CharacterDetails characterDetails;
  final FavoriteCharacter favoriteCharacter;

  DetailsLoadedState({
    required this.characterDetails,
    required this.favoriteCharacter,
  });

  @override
  List<Object?> get props => [characterDetails, favoriteCharacter];
}

class ErrorState extends CharacterDetailsState {
  final Failure failure;

  ErrorState({required this.failure});

  @override
  List<Object?> get props => [failure];
}
