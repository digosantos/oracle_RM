import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final String name;
  final String imageUrl;
  final String specie;
  final int episodesAmount;

  const Character({
    required this.name,
    required this.imageUrl,
    required this.specie,
    required this.episodesAmount,
  });

  @override
  List<Object?> get props => [name, imageUrl, specie, episodesAmount];
}
