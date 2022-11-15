import 'package:equatable/equatable.dart';

abstract class CharactersListingEvent extends Equatable {
  const CharactersListingEvent();

  @override
  List<Object?> get props => [];
}

class GetAllCharactersEvent extends CharactersListingEvent {}
