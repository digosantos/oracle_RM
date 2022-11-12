import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:oracle_rm/core/characters/data/models/models.dart';
import 'package:oracle_rm/core/characters/domain/entities/character.dart';

import '../../../../utils/faux.dart';
import '../../../../utils/fixtures/fixture_reader.dart';

void main() {
  late CharacterModel rick;

  setUp(() {
    rick = Faux.characterModel;
  });

  group('CharacterModel', () {
    test('should be a subclass of Character entity', () {
      expect(rick, isA<Character>());
    });

    test('should successfully parse data from JSON', () {
      final Map<String, dynamic> characterMap = jsonDecode(
        fixture(name: '/characters/character.json'),
      );
      final sut = CharacterModel.fromJson(characterMap['data']['character']);
      expect(sut, rick);
    });
  });
}
