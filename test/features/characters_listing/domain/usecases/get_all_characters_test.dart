import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/features/characters_listing/domain/entities/character.dart';
import 'package:oracle_rm/features/characters_listing/domain/repositories/repositories.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';

class MockCharactersRepository extends Mock implements CharactersRepository {}

void main() {
  group('Get all characters use case', () {
    late MockCharactersRepository mockCharactersRepository;
    late GetAllCharacters getAllCharactersUseCase;

    const character = Character(name: 'Digo', imageUrl: 'randomURL', specie: 'Human', episodesAmount: 0);
    final List<Character> characters = [character];

    setUpAll(() {
      mockCharactersRepository = MockCharactersRepository();
      getAllCharactersUseCase = GetAllCharacters(charactersRepository: mockCharactersRepository);
    });

    test('should return list of characters from repository', () async {
      when(mockCharactersRepository.getAllCharacters()).thenAnswer((_) async => Right(characters));

      final sut = await getAllCharactersUseCase.execute();

      expect(sut, Right(characters));
      verify(mockCharactersRepository.getAllCharacters()).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });
  });
}
