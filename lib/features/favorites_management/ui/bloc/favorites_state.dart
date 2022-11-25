import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/error/error.dart';

import '../../../../core/favorites/domain/entities/entities.dart';

abstract class FavoritesState extends Equatable {
  final bool shouldRebuild;

  const FavoritesState({this.shouldRebuild = false});

  @override
  List<Object?> get props => [shouldRebuild];
}

class FavoritesInitialState extends FavoritesState {}

class FavoritesLoadingState extends FavoritesState {}

class FavoritesListLoadedState extends FavoritesState {
  final List<FavoriteCharacter> charactersList;

  const FavoritesListLoadedState({required this.charactersList});

  @override
  List<Object?> get props => [charactersList];
}

class FavoritesListErrorState extends FavoritesState {
  final Failure failure;

  const FavoritesListErrorState({required this.failure});

  @override
  List<Object?> get props => [failure];
}
