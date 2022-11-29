import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:oracle_rm/core/characters/data/models/models.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';

import '../../../../utils/faux.dart';
import '../../../../utils/fixtures/fixture_reader.dart';

void main() {
  late CharacterDetailsModel rick;

  setUp(() {
    rick = Faux.characterDetailsModel;
  });

  group('CharacterDetailsModel', () {
    test('should be a subclass of CharacterDetails entity', () {
      expect(rick, isA<CharacterDetails>());
    });

    test('should successfully parse data from JSON', () {
      final Map<String, dynamic> characterDetailsMap = jsonDecode(
        fixture(name: '/characters/character_details.json'),
      );
      final sut = CharacterDetailsModel.fromJson(characterDetailsMap);
      expect(sut, rick);
    });
  });
}
