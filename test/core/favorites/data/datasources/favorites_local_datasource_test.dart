import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:oracle_rm/core/favorites/data/datasources/datasources.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/faux.dart';
import '../../../../utils/fixtures/fixture_reader.dart';

@GenerateMocks([FavoritesLocalDataSource])
void main() {
  late SharedPreferences sharedPreferences;
  late FavoritesLocalDataSourceImpl favoritesLocalDataSourceImpl;

  final characterId = Faux.character.id;
  final emptyFavorites = Map<String, Object>.from(jsonDecode(
    fixture(name: '/favorites/empty_favorites.json'),
  ));
  final favoriteCharacters = Map<String, Object>.from(jsonDecode(
    fixture(name: '/favorites/favorite_characters.json'),
  ));

  setUpAll(() async {
    SharedPreferences.setMockInitialValues(emptyFavorites);
    sharedPreferences = await SharedPreferences.getInstance();
    favoritesLocalDataSourceImpl = FavoritesLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  });

  group('FavoritesLocalDataSourceImpl', () {
    test('should save characterId', () async {
      SharedPreferences.setMockInitialValues(emptyFavorites);
      final sut = await favoritesLocalDataSourceImpl.save(characterId: characterId);

      expect(sut, true);
      expect(sharedPreferences.getStringList(Faux.favoritesKey), [Faux.character.id]);
    });

    test('should remove characterId', () async {
      SharedPreferences.setMockInitialValues(favoriteCharacters);
      final sut = await favoritesLocalDataSourceImpl.remove(characterId: characterId);

      expect(sut, true);
      expect(sharedPreferences.getStringList(Faux.favoritesKey), ['2']);
    });
  });
}
