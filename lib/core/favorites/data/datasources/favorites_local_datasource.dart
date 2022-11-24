import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritesLocalDataSource {
  List<String> getAll();
  Future<bool> update({required String characterId});
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences sharedPreferences;

  final String favoritesKey = 'favorites';

  FavoritesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  List<String> getAll() {
    return sharedPreferences.getStringList(favoritesKey) ?? [];
  }

  /// NOTE: so far, this method persists values of String type only.
  /// It could be improved to persist other types or we should consider
  /// using more powerful local database.
  @override
  Future<bool> update({required String characterId}) async {
    final favorites = sharedPreferences.getStringList(favoritesKey);

    if (favorites != null) {
      if (favorites.contains(characterId)) {
        favorites.remove(characterId);
      } else {
        favorites.add(characterId);
      }
      print(favorites);
      return await sharedPreferences.setStringList('favorites', favorites);
    } else {
      /// Create preferences with key
      return await sharedPreferences.setStringList(favoritesKey, [characterId]);
    }
  }
}
