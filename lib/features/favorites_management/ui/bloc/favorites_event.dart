import 'package:equatable/equatable.dart';

import '../../../../core/favorites/domain/entities/entities.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class GetFavoriteCharactersEvent extends FavoritesEvent {}

class SetupFavoritesStreamEvent extends FavoritesEvent {}

class FavoriteTappedEvent extends FavoritesEvent {
  final FavoriteCharacter favoriteCharacter;

  const FavoriteTappedEvent({required this.favoriteCharacter});

  @override
  List<Object?> get props => [favoriteCharacter];
}
