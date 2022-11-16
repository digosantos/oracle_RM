import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oracle_rm/core/characters/domain/entities/entities.dart';
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
    const Character character = Faux.character;
    final RequestedCharacter requestedCharacter = RequestedCharacter(id: character.id);

    test('should emit [LoadingState, DetailsLoadedState] when data is successfully retrieved', () async {
      when(mockGetCharacterDetailsUseCase(any)).thenAnswer((_) async => const Right(character));

      final expectedStates = [
        LoadingState(),
        DetailsLoadedState(character: character),
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
