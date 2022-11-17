import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oracle_rm/features/character_details/domain/usecases/get_character_details.dart';
import 'package:oracle_rm/features/character_details/ui/bloc/bloc.dart';

import '../../../../core/injection_container.dart';

class CharacterDetailsPage extends StatelessWidget {
  final RequestedCharacterParam requestedCharacter;

  final characterDetailsBloc = sl<CharacterDetailsBloc>();

  CharacterDetailsPage({Key? key, required this.requestedCharacter}) : super(key: key) {
    characterDetailsBloc.add(GetCharacterDetailsEvent(requestedCharacter: requestedCharacter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text('R&M Oracle'),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
        bloc: characterDetailsBloc,
        builder: (context, state) {
          if (state is DetailsLoadedState) {
            final characterDetails = state.characterDetails;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 36),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Text(
                    characterDetails.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        characterDetails.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Espécie: ${characterDetails.species}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Total de Episódios: ${characterDetails.episodesIds.length.toString()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 42),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    label: const Text(
                      'Favoritar',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          side: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
