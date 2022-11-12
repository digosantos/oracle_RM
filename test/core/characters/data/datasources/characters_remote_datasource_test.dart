import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/characters/data/datasources/characters_remote_datasource.dart';
import 'package:oracle_rm/core/network/queries/get_all_characters.dart';

import '../../../../utils/fixtures/fixture_reader.dart';
import '../../../../utils/utils.dart';
import '../../../network/base_network_client_test.mocks.dart';

@GenerateMocks([CharactersRemoteDataSource])
void main() {
  late MockBaseNetworkClient mockClient;
  late CharactersRemoteDataSourceImpl charactersRemoteDataSource;

  setUp(() {
    mockClient = MockBaseNetworkClient();
    charactersRemoteDataSource =
        CharactersRemoteDataSourceImpl(client: mockClient);
  });

  group('Get character details', () {
    test('should return CharacterModel on successful query', () async {
      final characterModelId = Faux.characterModel.id;
      final Map<String, dynamic> characterMap = jsonDecode(
        fixture(name: '/characters/character.json'),
      );

      when(mockClient.query(
              document: Queries.getCharacterDetails(),
              params: {'id': characterModelId}))
          .thenAnswer((_) async => characterMap);

      final sut = await charactersRemoteDataSource.getCharacterDetails(
          id: characterModelId);

      expect(sut, Faux.characterModel);
    });
  });
}
