import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:oracle_rm/core/favorites/data/datasources/datasources.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/faux.dart';

@GenerateMocks([FavoritesLocalDataSource])
void main() {
  late SharedPreferences sharedPreferences;
  late FavoritesLocalDataSourceImpl favoritesLocalDataSourceImpl;

  final characterId = Faux.character.id;

  /// NOTE:
  /// Due to the issue [https://github.com/flutter/flutter/issues/28837]
  /// below tests had to be setup individually instead of using setUpAll
  /// method. setMockInitialValues doesn't let us set new values.
  group('FavoritesLocalDataSourceImpl getAll method', () {
    test('should get list of favorite characterIds', () async {
      const List<String> favoriteIdsList = ['999', '2'];
      await setupPreferences(Faux.favoritesKey, favoriteIdsList);
      sharedPreferences = await SharedPreferences.getInstance();
      favoritesLocalDataSourceImpl = FavoritesLocalDataSourceImpl(sharedPreferences: sharedPreferences);

      final sut = favoritesLocalDataSourceImpl.getAll();

      expect(sut, favoriteIdsList);
      expect(sharedPreferences.getStringList(Faux.favoritesKey), favoriteIdsList);
    });

    test('should get empty list of favorite characterIds', () async {
      await setupPreferences(Faux.favoritesKey, []);
      sharedPreferences = await SharedPreferences.getInstance();
      favoritesLocalDataSourceImpl = FavoritesLocalDataSourceImpl(sharedPreferences: sharedPreferences);

      final sut = favoritesLocalDataSourceImpl.getAll();

      expect(sut, []);
      expect(sharedPreferences.getStringList(Faux.favoritesKey), []);
    });
  });

  group('FavoritesLocalDataSourceImpl update', () {
    test('should save characterId', () async {
      const updatedFavorite = Faux.updatedFavorite;
      await setupPreferences(Faux.favoritesKey, []);
      sharedPreferences = await SharedPreferences.getInstance();
      favoritesLocalDataSourceImpl = FavoritesLocalDataSourceImpl(sharedPreferences: sharedPreferences);

      final sut = await favoritesLocalDataSourceImpl.update(characterId: characterId);

      expect(sut.isFavorite, updatedFavorite.isFavorite);
      expect(sut.characterId, updatedFavorite.characterId);
      expect(sharedPreferences.getStringList(Faux.favoritesKey), [Faux.character.id]);
    });

    test('should remove characterId', () async {
      const updatedNotFavorite = Faux.updatedNotFavorite;
      await setupPreferences(Faux.favoritesKey, ['1', '2']);
      sharedPreferences = await SharedPreferences.getInstance();
      favoritesLocalDataSourceImpl = FavoritesLocalDataSourceImpl(sharedPreferences: sharedPreferences);

      final sut = await favoritesLocalDataSourceImpl.update(characterId: characterId);

      expect(sut.isFavorite, updatedNotFavorite.isFavorite);
      expect(sut.characterId, updatedNotFavorite.characterId);
      expect(sharedPreferences.getStringList(Faux.favoritesKey), ['2']);
    });
  });
}

Future setupPreferences(String key, List<String> value) async {
  SharedPreferences.setMockInitialValues(<String, Object>{'flutter.$key': value});
  final preferences = await SharedPreferences.getInstance();
  await preferences.setStringList(key, value);
}
