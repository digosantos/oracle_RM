import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:oracle_rm/core/characters/data/models/models.dart';
import 'package:oracle_rm/core/characters/domain/entities/character.dart';

import '../../../../utils/fixtures/fixture_reader.dart';

void main() {
  late CharacterModel rick;

  setUp(() {
    rick = const CharacterModel(
      id: '1',
      name: 'Rick Sanchez',
      imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      species: 'Human',
      episodesAmount: 3,
    );
  });

  group('CharacterModel', () {
    test('should be a subclass of Character entity', () {
      expect(rick, isA<Character>());
    });

    test('should successfully parse data from JSON', () {
      final Map<String, dynamic> allCharactersMap = jsonDecode(
        fixture(name: '/characters/character.json'),
      );
      final sut = CharacterModel.fromJson(allCharactersMap);
      expect(sut, rick);
    });
  });
}
