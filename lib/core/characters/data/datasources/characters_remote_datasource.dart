import 'package:oracle_rm/core/network/base_network_client.dart';
import 'package:oracle_rm/core/network/queries/queries.dart';

import '../../../../features/characters_listing/domain/usecases/usecases.dart';
import '../models/models.dart';

abstract class CharactersRemoteDataSource {
  Future<CharactersResponseModel> getAllCharacters({required int pageNumber, Filter? filter});
  Future<List<CharacterModel>> getCharactersList({required List<String> characterIdList});
  Future<CharacterDetailsModel> getCharacterDetails({required String id, required List<String> episodesIds});
}

class CharactersRemoteDataSourceImpl implements CharactersRemoteDataSource {
  final BaseNetworkClient client;

  CharactersRemoteDataSourceImpl({required this.client});

  @override
  Future<CharactersResponseModel> getAllCharacters({required int pageNumber, Filter? filter}) async {
    Map<String, dynamic> params = {'page': pageNumber, 'filter': {}};

    if (filter != null) {
      switch (filter.filterType) {
        case FilterType.name:
          params['filter'] = {'name': filter.searchText};
          break;
        case FilterType.species:
          params['filter'] = {'species': filter.searchText};
          break;
      }
    }

    final result = await client.query(
      document: Queries.getAllCharacters(),
      params: params,
    );
    return CharactersResponseModel.fromJson(result['characters']);
  }

  @override
  Future<CharacterDetailsModel> getCharacterDetails({required String id, required List<String> episodesIds}) async {
    final result = await client.query(
      document: Queries.getCharacterDetails(),
      params: {'id': id, 'episodesIds': episodesIds},
    );
    return CharacterDetailsModel.fromJson(result);
  }

  @override
  Future<List<CharacterModel>> getCharactersList({required List<String> characterIdList}) async {
    final result = await client.query(
      document: Queries.getCharactersById(),
      params: {'ids': characterIdList},
    );
    return List<CharacterModel>.from(
      result['charactersByIds'].map((character) => CharacterModel.fromJson(character)),
    );
  }
}
