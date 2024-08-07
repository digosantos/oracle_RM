import 'package:oracle_rm/core/characters/data/models/models.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/core/episodes/data/data.dart';
import 'package:oracle_rm/core/episodes/domain/entities/entities.dart';
import 'package:oracle_rm/core/favorites/data/models/models.dart';
import 'package:oracle_rm/core/favorites/domain/entities/entities.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/get_all_characters.dart';

class Faux {
  static const character = Character(
    id: '1',
    name: 'Rick Sanchez',
    imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    species: 'Human',
    episodesIds: ['1', '2', '3'],
  );

  static const getCharactersParams = GetCharactersParams(pageNumber: 1);

  static const favoriteCharacter = FavoriteCharacter(
    character: Faux.characterModel,
    isFavorite: true,
  );

  static const updatedFavorite = UpdatedFavorite(
    characterId: '1',
    isFavorite: true,
  );

  static const updatedNotFavorite = UpdatedFavorite(
    characterId: '1',
    isFavorite: false,
  );

  static const charactersResponse = CharactersResponse(
    nextPage: 1,
    charactersList: [Faux.character],
  );

  static const favoriteCharactersResponse = FavoriteCharactersResponse(
    nextPage: 1,
    charactersList: [Faux.favoriteCharacter],
  );

  static const favoriteCharactersResponseNextPageNull =
      FavoriteCharactersResponse(
    nextPage: null,
    charactersList: [Faux.favoriteCharacter],
  );

  static const charactersResponseNextPageNull = CharactersResponse(
    nextPage: null,
    charactersList: [Faux.character],
  );

  static const charactersResponseModel = CharactersResponseModel(
    nextPage: 2,
    characterModelList: [Faux.characterModel],
  );

  static const characterDetails = CharacterDetails(
    id: '1',
    name: 'Rick Sanchez',
    imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    species: 'Human',
    episodesIds: ['1', '2', '3'],
    status: 'Alive',
    origin: 'Earth (C-137)',
    location: 'Citadel of Ricks',
    createdAt: '2017-11-04T18:48:46.250Z',
    episodes: episodes,
  );

  static const episode = Episode(name: 'Pilot', airDate: 'December 2, 2013');
  static const episodes = [
    episode,
    Episode(name: 'Lawnmower Dog', airDate: 'December 9, 2013'),
    Episode(name: 'Anatomy Park', airDate: 'December 16, 2013'),
  ];

  static const episodeModel =
      EpisodeModel(name: 'Pilot', airDate: 'December 2, 2013');

  static const episodesModels = [
    episodeModel,
    EpisodeModel(name: 'Lawnmower Dog', airDate: 'December 9, 2013'),
    EpisodeModel(name: 'Anatomy Park', airDate: 'December 16, 2013'),
  ];

  static const characterModel = CharacterModel(
    id: '1',
    name: 'Rick Sanchez',
    imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    species: 'Human',
    episodesIds: ['1', '2', '3'],
  );

  static const characterDetailsModel = CharacterDetailsModel(
    id: '1',
    name: 'Rick Sanchez',
    imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    species: 'Human',
    episodesIds: ['1', '2', '3'],
    status: 'Alive',
    origin: 'Earth (C-137)',
    location: 'Citadel of Ricks',
    createdAt: '2017-11-04T18:48:46.250Z',
    episodes: episodesModels,
  );

  static const allCharactersModelList = [
    characterModel,
    CharacterModel(
      id: '2',
      name: 'Morty Smith',
      imageUrl: 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
      species: 'Human',
      episodesIds: ['1', '2', '3', '4', '5'],
    ),
  ];

  static const episodesIds = ['1', '2', '3'];

  static const favoritesKey = 'favorites';
  static const emptyFavorites = [];
  static const favorites = ['999', '2'];
}
