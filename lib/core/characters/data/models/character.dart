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
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'],
      species: json['species'],
      episodesAmount: (json['episode'] as List).length,
    );
  }
}
