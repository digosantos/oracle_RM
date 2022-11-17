import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/character_details/ui/bloc/bloc.dart';
import 'package:oracle_rm/features/characters_listing/domain/usecases/usecases.dart';

import '../../../../utils/faux.dart';
import './character_details_bloc_test.mocks.dart';

@GenerateMocks([GetCharacterDetails])
void main() {
  late MockGetCharacterDetails mockGetCharacterDetailsUseCase;
  late CharacterDetailsBloc characterDetailsBloc;

  setUpAll(() {
    mockGetCharacterDetailsUseCase = MockGetCharacterDetails();
    characterDetailsBloc = CharacterDetailsBloc(getCharacterDetailsUseCase: mockGetCharacterDetailsUseCase);
  });

  test('verify initial state is InitialState', () {
    expect(characterDetailsBloc.state, InitialState());
  });

  group('GetCharacterDetailsEvent', () {
    const characterDetails = Faux.characterDetails;
    const episodesIds = Faux.episodesIds;
    final RequestedCharacterParam requestedCharacter = RequestedCharacterParam(id: characterDetails.id, episodesIds: episodesIds);

    test('should emit [LoadingState, DetailsLoadedState] when data is successfully retrieved', () async {
      when(mockGetCharacterDetailsUseCase(any)).thenAnswer((_) async => const Right(characterDetails));

      final expectedStates = [
        LoadingState(),
        DetailsLoadedState(characterDetails: characterDetails),
      ];

      characterDetailsBloc.add(GetCharacterDetailsEvent(requestedCharacter: requestedCharacter));

      expect(characterDetailsBloc.stream, emitsInOrder(expectedStates));
    });

    test('should emit [LoadingState, ErrorState] when fails to retrieve data', () {
      const appError = AppError(properties: []);
      when(mockGetCharacterDetailsUseCase(any)).thenAnswer((_) async => const Left(appError));

      final expectedStates = [
        LoadingState(),
        ErrorState(failure: appError),
      ];

      characterDetailsBloc.add(GetCharacterDetailsEvent(requestedCharacter: requestedCharacter));

      expect(characterDetailsBloc.stream, emitsInOrder(expectedStates));
    });
  });
}
