import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';

import '../../../../core/characters/domain/repositories/repositories_mocks.dart';
import '../../../../utils/utils.dart';

void main() {
  group('Get all characters use case', () {
    late MockCharactersRepository mockCharactersRepository;
    late GetAllCharacters getAllCharactersUseCase;

    const getCharactersParams = Faux.getCharactersParams;
    const FavoriteCharactersResponse favoriteCharactersResponse =
        Faux.favoriteCharactersResponse;

    setUp(() {
      mockCharactersRepository = MockCharactersRepository();
      getAllCharactersUseCase =
          GetAllCharacters(charactersRepository: mockCharactersRepository);
    });

    test('should return list of characters from repository', () async {
      when(mockCharactersRepository.getAllCharacters(
              pageNumber: getCharactersParams.pageNumber))
          .thenAnswer((_) async => const Right(favoriteCharactersResponse));

      final sut = await getAllCharactersUseCase(getCharactersParams);

      expect(sut, const Right(favoriteCharactersResponse));
      verify(mockCharactersRepository.getAllCharacters(
              pageNumber: getCharactersParams.pageNumber))
          .called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });

    test('should return AppError from repository', () async {
      const appError = AppError(properties: []);
      when(mockCharactersRepository.getAllCharacters(
              pageNumber: getCharactersParams.pageNumber))
          .thenAnswer((_) async => const Left(appError));

      final sut = await getAllCharactersUseCase(getCharactersParams);

      expect(sut, const Left(appError));
      verify(mockCharactersRepository.getAllCharacters(
              pageNumber: getCharactersParams.pageNumber))
          .called(1);
      verifyNoMoreInteractions(mockCharactersRepository);
    });
  });
}
