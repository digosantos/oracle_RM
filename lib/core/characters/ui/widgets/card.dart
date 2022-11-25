import 'package:flutter/material.dart';
import 'package:oracle_rm/core/characters/ui/widgets/favorite_button.dart';

import '../../../common/ui/text_styles.dart';
import '../../../favorites/domain/entities/entities.dart';
import '../../../injection_container.dart';

abstract class CardDelegate {
  void onPressed({required FavoriteCharacter favoriteCharacter});
}

abstract class FavoriteButtonDelegate {
  void onFavoritePressed({required FavoriteCharacter favoriteCharacter});
}

class CharacterCard extends StatelessWidget with FavoriteButtonDelegate {
  final FavoriteCharacter favoriteCharacter;
  final CardDelegate cardDelegate;
  final FavoriteButtonDelegate favoriteButtonDelegate;

  TextStyle get subtitle18 => sl<TextStyles>().subtitle18;

  const CharacterCard({
    Key? key,
    required this.favoriteCharacter,
    required this.cardDelegate,
    required this.favoriteButtonDelegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cardDelegate.onPressed(favoriteCharacter: favoriteCharacter);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 4),
            color: (favoriteCharacter.isFavorite) ? Colors.yellowAccent : Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                favoriteCharacter.character.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    favoriteCharacter.character.imageUrl,
                    fit: BoxFit.fill,
                    height: 300,
                    width: 300,
                    loadingBuilder: (_, image, loadingProgress) {
                      if (loadingProgress == null) return image;
                      return const SizedBox(
                        height: 300,
                        width: 300,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Espécie: ${favoriteCharacter.character.species}',
                textAlign: TextAlign.center,
                style: subtitle18,
              ),
              const SizedBox(height: 12),
              Text(
                'Total de Episódios: ${favoriteCharacter.character.episodesIds.length.toString()}',
                textAlign: TextAlign.center,
                style: subtitle18,
              ),
              const SizedBox(height: 42),
              FavoriteButton(favoriteCharacter: favoriteCharacter, favoriteButtonDelegate: this),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onFavoritePressed({required FavoriteCharacter favoriteCharacter}) {
    favoriteButtonDelegate.onFavoritePressed(favoriteCharacter: favoriteCharacter);
  }
}
