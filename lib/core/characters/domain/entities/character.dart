import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final String specie;
  final int episodesAmount;

  const Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.specie,
    required this.episodesAmount,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, specie, episodesAmount];
}
