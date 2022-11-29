import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:oracle_rm/core/error/error.dart';

abstract class UseCase<Type, Params> {
  FutureOr<Either<AppError, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
