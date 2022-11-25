import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';
import 'package:oracle_rm/core/favorites/domain/entities/entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/character_details/ui/bloc/bloc.dart';
import '../features/characters_listing/domain/usecases/usecases.dart';
import '../features/characters_listing/ui/bloc/bloc.dart';
import '../features/favorites_management/domain/usecases/usecases.dart';
import '../features/favorites_management/ui/bloc/bloc.dart';
import './characters/data/datasources/datasources.dart';
import './characters/data/repositories/repositories.dart';
import './characters/domain/entities/entities.dart';
import './characters/domain/repositories/repositories.dart';
import './common/ui/text_styles.dart';
import './domain/usecases/usecase.dart';
import './favorites/data/models/models.dart';
import './favorites/domain/usecases/usecases.dart';
import './favorites/data/repositories/repositories.dart';
import './favorites/domain/repositories/repositories.dart';
import './favorites/data/datasources/datasources.dart';
import './network/network.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// ---------------------
  /// Characters Listing
  /// ---------------------

  /// Bloc:
  sl.registerFactory(
    () => CharactersListingBloc(
      getAllCharactersUseCase: sl(),
      updateFavoriteUseCase: sl(),
      observeUpdatedFavoritesUseCase: sl(),
    ),
  );

  /// Use Cases:
  sl.registerLazySingleton<UseCase<FavoriteCharactersResponse, int>>(
    () => GetAllCharacters(charactersRepository: sl()),
  );

  sl.registerLazySingleton<UseCase<Stream<UpdatedFavorite>, NoParams>>(
    () => ObserveUpdatedFavorites(favoritesRepository: sl()),
  );

  /// ---------------------
  /// Character Details
  /// ---------------------

  /// Bloc:
  sl.registerFactory(
    () => CharacterDetailsBloc(
      getCharacterDetailsUseCase: sl(),
      updateFavoriteUseCase: sl(),
    ),
  );

  /// Use Cases:
  sl.registerLazySingleton<UseCase<CharacterDetails, RequestedCharacterParam>>(() => GetCharacterDetails(charactersRepository: sl()));

  /// ---------------------
  /// Favorites Management
  /// ---------------------

  /// Bloc:
  sl.registerFactory(
    () => FavoritesBloc(
      getFavoriteCharactersUseCase: sl(),
      updateFavoriteUseCase: sl(),
      observeUpdatedFavoritesUseCase: sl(),
    ),
  );

  /// Use Cases:
  sl.registerLazySingleton<UseCase<List<FavoriteCharacter>, NoParams>>(
    () => GetFavoritesListUseCase(favoritesRepository: sl()),
  );

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

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  /// Styles:
  sl.registerLazySingleton<TextStyles>(() => TextStyles());

  /// ---------------------
  /// Core (Characters)
  /// ---------------------

  /// Repositories:
  sl.registerLazySingleton<CharactersRepository>(
    () => CharactersRepositoryImpl(
      charactersRemoteDataSource: sl(),
      favoritesLocalDataSource: sl(),
    ),
  );

  /// Data sources:
  sl.registerLazySingleton<CharactersRemoteDataSource>(
    () => CharactersRemoteDataSourceImpl(client: sl()),
  );

  /// ---------------------
  /// Core (Favorites)
  /// ---------------------

  /// Use Cases:
  sl.registerLazySingleton<UseCase<UpdatedFavorite, String>>(
    () => UpdateFavorite(favoritesRepository: sl()),
  );

  /// Repositories:
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      favoritesLocalDataSource: sl(),
      charactersRepository: sl(),
    ),
  );

  /// Data sources:
  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSourceImpl(sharedPreferences: sl()),
  );
}
