import 'package:oracle_rm/core/characters/data/models/character.dart';
import 'package:oracle_rm/core/network/base_network_client.dart';
import 'package:oracle_rm/core/network/queries/queries.dart';

abstract class CharactersRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters();
  Future<CharacterModel> getCharacterDetails({required String id});
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final BaseNetworkClient client;

  CharactersRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    final result = await client.query(document: Queries.getAllCharacters());
    return List<CharacterModel>.from(result['characters']['results'].map((json) {
      return CharacterModel.fromJson(json);
    }));
  }

  @override
  Future<CharacterModel> getCharacterDetails({required String id}) async {
    final result = await client.query(
      document: Queries.getCharacterDetails(),
      params: {'id': id, 'episodesIds': []},
    );
    return CharacterModel.fromJson(result['character']);
  }
}
