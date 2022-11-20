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

  group('FavoritesLocalDataSourceImpl', () {
    /// NOTE:
    /// Due to the issue [https://github.com/flutter/flutter/issues/28837]
    /// below tests had to be setup individually instead of using setUpAll
    /// method. setMockInitialValues doesn't let us set new values.
    test('should save characterId', () async {
      await setupPreferences(Faux.favoritesKey, []);
      sharedPreferences = await SharedPreferences.getInstance();
      favoritesLocalDataSourceImpl = FavoritesLocalDataSourceImpl(sharedPreferences: sharedPreferences);
      final sut = await favoritesLocalDataSourceImpl.save(characterId: characterId);

      expect(sut, true);
      expect(sharedPreferences.getStringList(Faux.favoritesKey), [Faux.character.id]);
    });

    test('should remove characterId', () async {
      await setupPreferences(Faux.favoritesKey, ['999', '2']);
      sharedPreferences = await SharedPreferences.getInstance();
      favoritesLocalDataSourceImpl = FavoritesLocalDataSourceImpl(sharedPreferences: sharedPreferences);

      final sut = await favoritesLocalDataSourceImpl.remove(characterId: characterId);

      expect(sut, true);
      expect(sharedPreferences.getStringList(Faux.favoritesKey), ['2']);
    });
  });
}

Future setupPreferences(String key, List<String> value) async {
  SharedPreferences.setMockInitialValues(<String, Object>{'flutter.$key': value});
  final preferences = await SharedPreferences.getInstance();
  await preferences.setStringList(key, value);
}
