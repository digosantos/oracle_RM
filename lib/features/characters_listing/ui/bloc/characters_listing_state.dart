import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/core/error/error.dart';

abstract class CharactersListingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CharactersListInitialState extends CharactersListingState {}

class CharactersListLoadingState extends CharactersListingState {}

class CharactersListLoadedState extends CharactersListingState {
  final List<Character> charactersList;

  CharactersListLoadedState({required this.charactersList});

  @override
  List<Object?> get props => [charactersList];
}

class CharactersListErrorState extends CharactersListingState {
  final Failure failure;

  CharactersListErrorState({required this.failure});

  @override
  List<Object?> get props => [failure];
}
