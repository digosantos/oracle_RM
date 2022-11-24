import 'package:equatable/equatable.dart';

import '../../../characters/domain/entities/entities.dart';

class FavoriteCharacter extends Equatable {
  final Character character;
  final bool isFavorite;

  const FavoriteCharacter({required this.character, required this.isFavorite});

  factory FavoriteCharacter.update({required FavoriteCharacter favoriteCharacter}) {
    return FavoriteCharacter(character: favoriteCharacter.character, isFavorite: !favoriteCharacter.isFavorite);
  }

  @override
  List<Object?> get props => [character, isFavorite];
}
