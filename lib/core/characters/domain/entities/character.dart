import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String species;
  final List<String> episodesIds;

  const Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.species,
    required this.episodesIds,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, species, episodesIds];
}
