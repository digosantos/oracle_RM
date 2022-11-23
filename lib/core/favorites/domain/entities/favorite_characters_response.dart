import 'package:equatable/equatable.dart';

import './entities.dart';

class FavoriteCharactersResponse extends Equatable {
  final int? nextPage;
  final List<FavoriteCharacter> charactersList;

  const FavoriteCharactersResponse({required this.nextPage, required this.charactersList});

  @override
  List<Object?> get props => [nextPage, charactersList];
}
