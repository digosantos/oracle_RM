import 'package:oracle_rm/core/characters/data/models/models.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';

class Faux {
  static const character = Character(
    id: '999',
    name: 'Digo',
    imageUrl: 'imageUrl',
    species: 'Human',
    episodesAmount: 0,
  );

  static const characterModel = CharacterModel(
    id: '1',
    name: 'Rick Sanchez',
    imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    species: 'Human',
    episodesAmount: 3,
  );

  static const allCharactersModelList = [
    characterModel,
    CharacterModel(
      id: '2',
      name: 'Morty Smith',
      imageUrl: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      species: 'Human',
      episodesAmount: 5,
    ),
  ];
}
