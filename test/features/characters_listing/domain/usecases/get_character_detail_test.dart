import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';

import '../../../../core/characters/domain/repositories/repositories_mocks.dart';
import '../../../../utils/utils.dart';

void main() {
  group('Get character details', () {
    late MockCharactersRepository mockCharactersRepository;
    late GetCharacterDetails getCharacterDetailsUseCase;
    const character = Faux.character;
    const episodesIds = Faux.episodesIds;

    setUp(() {
      mockCharactersRepository = MockCharactersRepository();
      getCharacterDetailsUseCase = GetCharacterDetails(charactersRepository: mockCharactersRepository);
    });

    test('should get character details', () async {
      when(mockCharactersRepository.getCharacterDetails(id: character.id, episodesIds: episodesIds))
          .thenAnswer((_) async => const Right(character));

      final sut = await getCharacterDetailsUseCase(RequestedCharacterParam(id: character.id, episodesIds: episodesIds));

      expect(sut, const Right(character));
      verify(mockCharactersRepository.getCharacterDetails(id: character.id, episodesIds: episodesIds));
      verifyNoMoreInteractions(mockCharactersRepository);
    });

    test('should fail to get character details', () async {
      when(mockCharactersRepository.getCharacterDetails(id: character.id, episodesIds: episodesIds))
          .thenAnswer((_) async => const Left(AppError(properties: [])));

      final sut = await getCharacterDetailsUseCase(RequestedCharacterParam(id: character.id, episodesIds: episodesIds));

      expect(sut, const Left(AppError(properties: [])));
      verify(mockCharactersRepository.getCharacterDetails(id: character.id, episodesIds: episodesIds));
      verifyNoMoreInteractions(mockCharactersRepository);
    });
  });
}
