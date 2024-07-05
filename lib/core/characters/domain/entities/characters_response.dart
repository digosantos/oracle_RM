import 'package:equatable/equatable.dart';

import './entities.dart';

class CharactersResponse extends Equatable {
  final int? nextPage;
  final List<Character> charactersList;

  const CharactersResponse(
      {required this.nextPage, required this.charactersList});

  @override
  List<Object?> get props => [nextPage, charactersList];
}
