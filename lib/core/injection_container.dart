import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:oracle_rm/core/characters/data/datasources/datasources.dart';
import 'package:oracle_rm/core/characters/data/repositories/characters_repository_impl.dart';
import 'package:oracle_rm/core/characters/domain/repositories/characters_repository.dart';
import 'package:oracle_rm/core/network/network.dart';
import 'package:oracle_rm/features/character_details/ui/bloc/bloc.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

import 'characters/domain/entities/entities.dart';
import 'domain/usecases/usecase.dart';

final sl = GetIt.instance;

void init() {
  /// ---------------------
  /// Characters Listing
  /// ---------------------

  /// Bloc:
  sl.registerFactory(
    () => CharactersListingBloc(getAllCharactersUseCase: sl()),
  );

  /// Use Cases:
  sl.registerLazySingleton<UseCase<List<Character>, NoParams>>(() => GetAllCharacters(charactersRepository: sl()));

  /// ---------------------
  /// Character Details
  /// ---------------------

  /// Bloc:
  sl.registerFactory(
    () => CharacterDetailsBloc(getCharacterDetailsUseCase: sl()),
  );

  /// Use Cases:
  sl.registerLazySingleton<UseCase<Character, RequestedCharacter>>(() => GetCharacterDetails(charactersRepository: sl()));

  /// ---------------------
  /// Core
  /// ---------------------

  /// Network:
  sl.registerLazySingleton<BaseNetworkClient>(() => BaseNetworkClient(client: sl()));

  /// External:
  sl.registerLazySingleton<GraphQLClient>(
    () => GraphQLClient(
      link: HttpLink('https://rickandmortyapi.com/graphql/'),
      cache: GraphQLCache(),
    ),
  );

  /// ---------------------
  /// Core (Characters)
  /// ---------------------

  /// Repositories:
  sl.registerLazySingleton<CharactersRepository>(
    () => CharactersRepositoryImpl(charactersRemoteDataSource: sl()),
  );

  /// Data sources:
  sl.registerLazySingleton<CharactersRemoteDataSource>(
    () => CharactersRemoteDataSourceImpl(client: sl()),
  );
}
