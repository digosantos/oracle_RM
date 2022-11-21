import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/core/favorites/domain/usecases/get_favorites.dart';

import '../repositories/favorites_repository_test.mocks.dart';

void main() {
  late MockFavoritesRepository mockFavoritesRepository;
  late GetFavoritesUseCase getFavoritesUseCase;

  setUp(() {
    mockFavoritesRepository = MockFavoritesRepository();
    getFavoritesUseCase =
        GetFavoritesUseCase(favoritesRepository: mockFavoritesRepository);
  });

  group('Get favorites use case', () {
    final favoritesIdsList = ['999', '2'];

    test('should successfully retrieve favorites locally', () async {
      when(mockFavoritesRepository.getAll())
          .thenAnswer((_) async => Right(favoritesIdsList));

      final sut = await getFavoritesUseCase(NoParams());

      expect(sut, Right(favoritesIdsList));
      verify(mockFavoritesRepository.getAll()).called(1);
      verifyNoMoreInteractions(mockFavoritesRepository);
    });

    test('should fail to retrieve favorites locally', () async {
      when(mockFavoritesRepository.getAll())
          .thenAnswer((_) async => const Left(AppError(properties: [])));

      final sut = await getFavoritesUseCase(NoParams());

      expect(sut, const Left(AppError(properties: [])));
      verify(mockFavoritesRepository.getAll()).called(1);
      verifyNoMoreInteractions(mockFavoritesRepository);
    });
  });
}
