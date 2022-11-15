import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:oracle_rm/core/characters/data/datasources/datasources.dart';
import 'package:oracle_rm/core/characters/data/repositories/characters_repository_impl.dart';
import 'package:oracle_rm/core/characters/domain/repositories/characters_repository.dart';
import 'package:oracle_rm/core/network/network.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

final sl = GetIt.instance;

void init() {
  /// ---------------------
  /// Characters Listing
  /// ---------------------

  /// Bloc:
  sl.registerFactory(() => CharactersListingBloc(getAllCharactersUseCase: sl()));

  /// Use Cases:
  sl.registerLazySingleton(() => GetAllCharacters(charactersRepository: sl()));

  /// Repositories:
  sl.registerLazySingleton<CharactersRepository>(
    () => CharactersRepositoryImpl(charactersRemoteDataSource: sl()),
  );

  /// Data sources:
  sl.registerLazySingleton<CharactersRemoteDataSource>(
    () => CharactersRemoteDataSourceImpl(client: sl()),
  );

  /// ---------------------
  /// Core
  /// ---------------------

  /// Network:
  sl.registerLazySingleton(() => BaseNetworkClient(client: sl()));

  /// External:
  sl.registerLazySingleton(() => GraphQLClient(link: sl(), cache: sl()));
}
