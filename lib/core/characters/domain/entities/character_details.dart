import 'package:oracle_rm/core/characters/domain/entities/entities.dart';

import '../../../episodes/domain/entities/entities.dart';

class CharacterDetails extends Character {
  final String status;
  final String origin;
  final String location;
  final String createdAt;
  final List<Episode> episodes;

  const CharacterDetails({
    required String id,
    required String name,
    required String imageUrl,
    required String species,
    required List<String> episodesIds,
    required this.status,
    required this.origin,
    required this.location,
    required this.createdAt,
    required this.episodes,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          species: species,
          episodesIds: episodesIds,
        );

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        species,
        episodesIds,
        status,
        origin,
        location,
        createdAt,
        episodes,
      ];
}
