import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';

import '../../../../core/characters/domain/repositories/repositories_mocks.dart';
import '../../../../utils/utils.dart';

void main() {
  group('Get character details', () {
    late MockCharactersRepository mockCharactersRepository;
    late GetCharacterDetails getCharacterDetailsUseCase;
    const character = Faux.character;

    setUp(() {
      mockCharactersRepository = MockCharactersRepository();
      getCharacterDetailsUseCase =
          GetCharacterDetails(charactersRepository: mockCharactersRepository);
    });

    test('should get character details', () async {
      when(mockCharactersRepository.getCharacterDetails(id: character.id))
          .thenAnswer((_) async => const Right(character));

      final sut = await getCharacterDetailsUseCase(
          RequestedCharacter(id: character.id));

      expect(sut, const Right(character));
      verify(mockCharactersRepository.getCharacterDetails(id: character.id));
      verifyNoMoreInteractions(mockCharactersRepository);
    });
  });
}
