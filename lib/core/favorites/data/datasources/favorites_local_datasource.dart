import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritesLocalDataSource {
  Future<bool> save({required String characterId});
  Future<bool> remove({required String characterId});
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoritesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> remove({required String characterId}) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> save({required String characterId}) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
