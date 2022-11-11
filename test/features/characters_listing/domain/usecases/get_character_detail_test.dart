import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';

import '../../../../core/characters/domain/repositories/repositories_mocks.dart';

void main() {
  group('Get character details', () {
    late MockCharactersRepository mockCharactersRepository;
    late GetCharacterDetails getCharacterDetailsUseCase;
    const int characterId = 1;
    const character = Character(
      name: 'Digo',
      imageUrl: 'imageUrl',
      specie: 'Human',
      episodesAmount: 0,
    );

    setUp(() {
      mockCharactersRepository = MockCharactersRepository();
      getCharacterDetailsUseCase = GetCharacterDetails(charactersRepository: mockCharactersRepository);
    });

    test('should get character details', () async {
      when(mockCharactersRepository.getCharacterDetails(id: characterId)).thenAnswer((_) async => const Right(character));

      final sut = await getCharacterDetailsUseCase.execute(characterId: characterId);

      expect(sut, const Right(character));
      verify(mockCharactersRepository.getCharacterDetails(id: characterId));
      verifyNoMoreInteractions(mockCharactersRepository);
    });
  });
}
