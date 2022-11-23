import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/core/favorites/domain/usecases/usecases.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

import '../../../../utils/faux.dart';
import 'characters_listing_bloc_test.mocks.dart';

@GenerateMocks([GetAllCharacters, UpdateFavorite])
void main() {
  late MockGetAllCharacters mockGetAllCharactersUseCase;
  late MockUpdateFavorite mockUpdateFavorite;
  late CharactersListingBloc charactersListingBloc;

  setUpAll(() {
    mockGetAllCharactersUseCase = MockGetAllCharacters();
    mockUpdateFavorite = MockUpdateFavorite();
    charactersListingBloc = CharactersListingBloc(
      getAllCharactersUseCase: mockGetAllCharactersUseCase,
      updateFavoriteUseCase: mockUpdateFavorite,
    );
  });

  test('verify initial state is CharactersListInitialState', () {
    expect(charactersListingBloc.state, CharactersListInitialState());
  });

  group('GetAllCharactersEvent', () {
    const FavoriteCharactersResponse favoriteCharactersResponse = Faux.favoriteCharactersResponse;

    test('should emit [CharactersListLoadedState] with listLength equals 2 when nextPage is not null', () async {
      when(mockGetAllCharactersUseCase(any)).thenAnswer((_) async => const Right(favoriteCharactersResponse));

      final expectedStates = [
        CharactersListLoadedState(
          charactersList: favoriteCharactersResponse.charactersList,
          listLength: 2,
        ),
      ];

      charactersListingBloc.add(GetAllCharactersEvent());

      expect(charactersListingBloc.stream, emitsInOrder(expectedStates));
    });

    test('should emit [CharactersListLoadingState, CharactersListErrorState] when fails to retrieve data', () {
      const appError = AppError(properties: []);
      when(mockGetAllCharactersUseCase(any)).thenAnswer((_) async => const Left(appError));

      final expectedStates = [
        CharactersListErrorState(failure: appError),
      ];

      charactersListingBloc.add(GetAllCharactersEvent());

      expect(charactersListingBloc.stream, emitsInOrder(expectedStates));
    });
  });
}
