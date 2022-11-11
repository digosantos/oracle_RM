import 'package:oracle_rm/core/characters/domain/entities/entities.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required String id,
    required String name,
    required String imageUrl,
    required String species,
    required int episodesAmount,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          species: species,
          episodesAmount: episodesAmount,
        );

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final character = json['data']['character'];

    return CharacterModel(
      id: character['id'],
      name: character['name'],
      imageUrl: character['image'],
      species: character['species'],
      episodesAmount: (character['episode'] as List).length,
    );
  }
}
