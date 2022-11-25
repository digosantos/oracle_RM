import 'package:flutter/material.dart';
import 'package:oracle_rm/core/characters/ui/widgets/card.dart';

import '../../../favorites/domain/entities/entities.dart';

class FavoriteButton extends StatelessWidget {
  final FavoriteCharacter favoriteCharacter;
  final FavoriteButtonDelegate favoriteButtonDelegate;
  const FavoriteButton(
      {super.key,
      required this.favoriteCharacter,
      required this.favoriteButtonDelegate});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => favoriteButtonDelegate.onFavoritePressed(
          favoriteCharacter: favoriteCharacter),
      icon: Icon(Icons.favorite,
          color: (favoriteCharacter.isFavorite) ? Colors.white : Colors.red),
      label: Text(
        (favoriteCharacter.isFavorite) ? 'Desfavoritar' : 'Favoritar',
        style: TextStyle(
          color: (favoriteCharacter.isFavorite) ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            (favoriteCharacter.isFavorite) ? Colors.black : Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            side: BorderSide(
                color: (favoriteCharacter.isFavorite)
                    ? Colors.yellow
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}
