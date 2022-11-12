import 'package:oracle_rm/core/characters/data/models/character.dart';
import 'package:oracle_rm/core/network/base_network_client.dart';
import 'package:oracle_rm/core/network/queries/get_all_characters.dart';

abstract class CharactersRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters();
  Future<CharacterModel> getCharacterDetails({required String id});
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final BaseNetworkClient client;

  CharactersRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getAllCharacters() {
    // TODO: implement getAllCharacters
    throw UnimplementedError();
  }

  @override
  Future<CharacterModel> getCharacterDetails({required String id}) async {
    final result = await client.query(
      document: Queries.getAllCharacters(),
      params: {'id': '1'},
    );
    return CharacterModel.fromJson(result);
  }
}
