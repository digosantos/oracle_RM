import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final String name;
  final String airDate;

  const Episode({required this.name, required this.airDate});

  @override
  List<Object?> get props => [name, airDate];
}
