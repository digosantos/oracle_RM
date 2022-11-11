import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:oracle_rm/core/characters/data/models/models.dart';
import 'package:oracle_rm/core/characters/domain/entities/character.dart';

import '../../../../utils/fixtures/fixture_reader.dart';

void main() {
  const rick = CharacterModel(
    id: 1,
    name: 'Rick Sanchez',
    imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    specie: 'Human',
    episodesAmount: 5,
  );

  const morty = CharacterModel(
    id: 2,
    name: 'Morty Smith',
    imageUrl: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
    specie: 'Human',
    episodesAmount: 3,
  );

  const allCharacters = [rick, morty];

  test('should be a subclass of Character entity', () {
    expect(rick, isA<Character>());
  });

  group('fromJson', () {
    test('should return CharacterModel when JSON has valid data', () {
      final Map<String, dynamic> allCharactersMap = jsonDecode(fixture(name: 'all_characters.json'));

      final sut = CharacterModel.fromJson(allCharactersMap);

      expect(sut, allCharacters);
    });
  });
}
