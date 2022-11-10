import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic> properties;

  const Failure({required this.properties});

  @override
  List<Object?> get props => properties;
}

class AppError extends Failure {
  const AppError({required super.properties});
}
