import 'package:oracle_rm/core/error/error.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

abstract class FavoritesLocalDataSource {
  List<String> getAll();
  Future<UpdatedFavorite> update({required String characterId});
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
  Future<UpdatedFavorite> update({required String characterId}) async {
    var favorites = sharedPreferences.getStringList(favoritesKey) ?? [];

    bool isFavorite;

    if (favorites.contains(characterId)) {
      favorites.remove(characterId);
      isFavorite = false;
    } else {
      favorites.add(characterId);
      isFavorite = true;
    }

    if (await sharedPreferences.setStringList(favoritesKey, favorites)) {
      return UpdatedFavorite(characterId: characterId, isFavorite: isFavorite);
    } else {
      throw const AppError(properties: ['Failed to persist favorite locally']);
    }
  }
}
