import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritesLocalDataSource {
  Future<bool> save({required String characterId});
  Future<bool> remove({required String characterId});
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoritesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> remove({required String characterId}) async {
    final favorites = sharedPreferences.getStringList('favorites');
    favorites!.remove(characterId);
    return await sharedPreferences.setStringList('favorites', favorites);
  }

  @override
  Future<bool> save({required String characterId}) async {
    return await sharedPreferences.setStringList('favorites', [characterId]);
  }
}
