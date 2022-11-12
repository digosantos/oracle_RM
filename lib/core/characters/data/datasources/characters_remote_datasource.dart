import 'package:oracle_rm/core/characters/data/models/character.dart';

abstract class CharactersRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters();
  Future<CharacterModel> getCharacterDetails({required String id});
}
