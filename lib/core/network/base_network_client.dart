import 'package:graphql/client.dart';
import 'package:oracle_rm/core/error/exceptions.dart' as exception;

class BaseNetworkClient {
  final GraphQLClient client;

  BaseNetworkClient({required this.client});

  Future<Map<String, dynamic>> query({required String document, Map<String, dynamic>? params}) async {
    final options = QueryOptions(document: gql(document), variables: params ?? {});
    final result = await client.query(options);
    if (result.hasException) throw exception.ServerException();
    return result.data!;
  }
}
