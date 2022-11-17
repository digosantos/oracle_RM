import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String name;

  const Location({required this.name});

  @override
  List<Object?> get props => [name];
}
