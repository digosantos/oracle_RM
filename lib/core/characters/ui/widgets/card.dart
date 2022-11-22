import 'package:flutter/material.dart';

import '../../../common/ui/text_styles.dart';
import '../../../injection_container.dart';
import '../../domain/entities/entities.dart';

abstract class CardDelegate {
  void onPressed({required Character character});
}

class CharacterCard extends StatelessWidget {
  final Character character;
  final CardDelegate cardDelegate;

  TextStyle get subtitle18 => sl<TextStyles>().subtitle18;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.cardDelegate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => cardDelegate.onPressed(character: character),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 4),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                character.name,
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
                    character.imageUrl,
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
                'Espécie: ${character.species}',
                textAlign: TextAlign.center,
                style: subtitle18,
              ),
              const SizedBox(height: 12),
              Text(
                'Total de Episódios: ${character.episodesIds.length.toString()}',
                textAlign: TextAlign.center,
                style: subtitle18,
              ),
              const SizedBox(height: 42),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.favorite, color: Colors.red),
                label: const Text(
                  'Favoritar',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
