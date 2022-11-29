import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/network/base_network_client.dart';

import 'base_network_client_test.mocks.dart';

@GenerateMocks([GraphQLClient, BaseNetworkClient])
void main() {
  late MockGraphQLClient mockGraphQLClient;
  late BaseNetworkClient baseNetworkClient;

  setUp(() {
    mockGraphQLClient = MockGraphQLClient();
    baseNetworkClient = BaseNetworkClient(client: mockGraphQLClient);
  });

  group('BaseNetworkClient', () {
    const query = r'''{}''';

    test('should successfully retrieve query', () async {
      final queryOptions = QueryOptions(document: gql(query));
      final queryResult = QueryResult(
        options: queryOptions,
        source: QueryResultSource.network,
        data: {},
      );

      when(mockGraphQLClient.query(queryOptions))
          .thenAnswer((_) async => queryResult);

      final sut = await baseNetworkClient.query(document: query);

      expect(sut, {});
      verify(mockGraphQLClient.query(queryOptions));
      verifyNoMoreInteractions(mockGraphQLClient);
    });
  });
}
