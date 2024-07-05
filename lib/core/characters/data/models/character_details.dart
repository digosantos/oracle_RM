import 'package:oracle_rm/core/characters/domain/entities/entities.dart';

import '../../../episodes/data/data.dart';
import '../../../episodes/domain/entities/entities.dart';

class CharacterDetailsModel extends CharacterDetails {
  const CharacterDetailsModel({
    required String id,
    required String name,
    required String imageUrl,
    required String species,
    required List<String> episodesIds,
    required String status,
    required String origin,
    required String location,
    required String createdAt,
    required List<Episode> episodes,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          species: species,
          episodesIds: episodesIds,
          status: status,
          origin: origin,
          location: location,
          createdAt: createdAt,
          episodes: episodes,
        );

  factory CharacterDetailsModel.fromJson(Map<String, dynamic> json) {
    final character = json['character'];
    final episodesByIds = json['episodesByIds'];

    return CharacterDetailsModel(
      id: character['id'],
      name: character['name'],
      imageUrl: character['image'],
      species: character['species'],
      episodesIds: List<String>.from(
        episodesByIds.map((episode) => episode['id']),
      ),
      status: character['status'],
      origin: character['origin']['name'],
      location: character['location']['name'],
      createdAt: character['created'],
      episodes: List<Episode>.from(
        episodesByIds.map((episode) => EpisodeModel.fromJson(episode)),
      ),
    );
  }
}
