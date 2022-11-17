import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/core/error/error.dart';

abstract class CharacterDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends CharacterDetailsState {}

class LoadingState extends CharacterDetailsState {}

class DetailsLoadedState extends CharacterDetailsState {
  final CharacterDetails characterDetails;

  DetailsLoadedState({required this.characterDetails});

  @override
  List<Object?> get props => [characterDetails];
}

class ErrorState extends CharacterDetailsState {
  final Failure failure;

  ErrorState({required this.failure});

  @override
  List<Object?> get props => [failure];
}
