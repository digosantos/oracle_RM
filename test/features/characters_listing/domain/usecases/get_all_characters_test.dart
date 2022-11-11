import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';

import '../../../../core/characters/domain/repositories/repositories_mocks.dart';

void main() {
  group('Get all characters use case', () {
    late MockCharactersRepository mockCharactersRepository;
    late GetAllCharacters getAllCharactersUseCase;

    const character = Character(
      name: 'Digo',
      imageUrl: 'randomURL',
      specie: 'Human',
      episodesAmount: 0,
    );
    final List<Character> characters = [character];

    setUp(() {
      mockCharactersRepository = MockCharactersRepository();
      getAllCharactersUseCase = GetAllCharacters(charactersRepository: mockCharactersRepository);
    });

    test('should return list of characters from repository', () async {
      when(mockCharactersRepository.getAllCharacters()).thenAnswer((_) async => Right(characters));

      final sut = await getAllCharactersUseCase();

      expect(sut, Right(characters));
      verify(mockCharactersRepository.getAllCharacters()).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });

    test('should return AppError from repository', () async {
      const appError = AppError(properties: []);
      when(mockCharactersRepository.getAllCharacters()).thenAnswer((_) async => const Left(appError));

      final sut = await getAllCharactersUseCase();

      expect(sut, const Left(appError));
      verify(mockCharactersRepository.getAllCharacters()).called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });
  });
}
