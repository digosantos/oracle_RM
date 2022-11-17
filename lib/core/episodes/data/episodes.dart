import '../domain/entities/entities.dart';

class EpisodeModel extends Episode {
  const EpisodeModel({required super.name, required super.airDate});

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(name: json['name'], airDate: json['air_date']);
  }
}
