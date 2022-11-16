import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oracle_rm/core/domain/usecases/usecase.dart';
import 'package:oracle_rm/core/error/error.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

import '../../../../core/characters/domain/entities/entities.dart';

class CharactersListingBloc extends Bloc<CharactersListingEvent, CharactersListingState> {
  final UseCase<List<Character>, NoParams> getAllCharactersUseCase;

  CharactersListingBloc({required this.getAllCharactersUseCase}) : super(CharactersListInitialState()) {
    on<GetAllCharactersEvent>(_loadCharacters);
  }

  /// Callbacks
  void _loadCharacters(GetAllCharactersEvent event, Emitter emit) async {
    emit(CharactersListLoadingState());
    final response = await getAllCharactersUseCase(NoParams());
    emit(response.fold(
      (failure) => CharactersListErrorState(
        failure: AppError(properties: failure.properties),
      ),
      (charactersList) => CharactersListLoadedState(charactersList: charactersList),
    ));
  }
}
