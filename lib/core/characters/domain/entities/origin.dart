import 'package:equatable/equatable.dart';

class Origin extends Equatable {
  final String name;

  const Origin({required this.name});

  @override
  List<Object?> get props => [name];
}
