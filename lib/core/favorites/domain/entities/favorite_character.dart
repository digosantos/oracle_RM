import '../../../characters/domain/entities/entities.dart';

class FavoriteCharacter {
  final Character character;
  final bool isFavorite;

  const FavoriteCharacter({required this.character, required this.isFavorite});
}
