import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

import '../../../../utils/faux.dart';
import 'characters_listing_bloc_test.mocks.dart';

@GenerateMocks([GetAllCharacters])
void main() {
  late MockGetAllCharacters mockGetAllCharactersUseCase;
  late CharactersListingBloc charactersListingBloc;

  setUpAll(() {
    mockGetAllCharactersUseCase = MockGetAllCharacters();
    charactersListingBloc = CharactersListingBloc(getAllCharactersUseCase: mockGetAllCharactersUseCase);
  });

  test('verify initial state is CharactersListLoadingState', () {
    expect(charactersListingBloc.state, CharactersListInitialState());
  });

  group('GetAllCharactersEvent', () {
    final List<Character> charactersList = [Faux.character, Faux.character];

    test('should emit [CharactersListLoadingState, CharactersListLoadedState] when data is successfully retrieved', () async {
      when(mockGetAllCharactersUseCase(any)).thenAnswer((_) async => Right(charactersList));

      final expectedStates = [
        CharactersListLoadingState(),
        CharactersListLoadedState(charactersList: charactersList),
      ];

      charactersListingBloc.add(GetAllCharactersEvent());

      expect(charactersListingBloc.stream, emitsInOrder(expectedStates));
    });

    test('should emit [CharactersListLoadingState, CharactersListErrorState] when fails to retrieve data', () {
      const appError = AppError(properties: []);
      when(mockGetAllCharactersUseCase(any)).thenAnswer((_) async => const Left(appError));

      final expectedStates = [
        CharactersListLoadingState(),
        CharactersListErrorState(failure: appError),
      ];

      charactersListingBloc.add(GetAllCharactersEvent());

      expect(charactersListingBloc.stream, emitsInOrder(expectedStates));
    });
  });
}
