import 'package:oracle_rm/core/characters/data/models/character.dart';

import '../../domain/entities/entities.dart';

class CharactersResponseModel extends CharactersResponse {
  const CharactersResponseModel({
    required int? nextPage,
    required List<CharacterModel> characterModelList,
  }) : super(nextPage: nextPage, charactersList: characterModelList);

  factory CharactersResponseModel.fromJson(Map<String, dynamic> json) {
    return CharactersResponseModel(
      nextPage: json['info']['next'],
      characterModelList: List<CharacterModel>.from(
        json['results'].map((json) {
          return CharacterModel.fromJson(json);
        }),
      ),
    );
  }
}
