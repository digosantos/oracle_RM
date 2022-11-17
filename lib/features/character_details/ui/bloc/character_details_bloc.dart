import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/character_details/ui/bloc/bloc.dart';

import '../../../../core/characters/domain/entities/entities.dart';
import '../../../characters_listing/domain/usecases/usecases.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final UseCase<CharacterDetails, RequestedCharacterParam>
      getCharacterDetailsUseCase;

  CharacterDetailsBloc({required this.getCharacterDetailsUseCase})
      : super(InitialState()) {
    on<GetCharacterDetailsEvent>(_loadCharacterDetails);
  }

  /// Callbacks
  void _loadCharacterDetails(
      GetCharacterDetailsEvent event, Emitter emit) async {
    emit(LoadingState());
    final response = await getCharacterDetailsUseCase(event.requestedCharacter);
    emit(response.fold(
      (failure) => ErrorState(
        failure: AppError(properties: failure.properties),
      ),
      (characterDetails) =>
          DetailsLoadedState(characterDetails: characterDetails),
    ));
  }
}
