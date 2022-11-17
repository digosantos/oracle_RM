import 'package:oracle_rm/core/network/base_network_client.dart';
import 'package:oracle_rm/core/network/queries/queries.dart';

import '../models/models.dart';

abstract class CharactersRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters();
  Future<CharacterDetailsModel> getCharacterDetails({required String id, required List<String> episodesIds});
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
  Future<CharacterDetailsModel> getCharacterDetails({required String id, required List<String> episodesIds}) async {
    final result = await client.query(
      document: Queries.getCharacterDetails(),
      params: {'id': id, 'episodesIds': episodesIds},
    );
    return CharacterDetailsModel.fromJson(result);
  }
}
