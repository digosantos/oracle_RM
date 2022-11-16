import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oracle_rm/core/characters/ui/widgets/card.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

import '../../../../core/injection_container.dart';

class CharactersListingPage extends StatelessWidget {
  final charactersListBloc = sl<CharactersListingBloc>();

  CharactersListingPage({Key? key}) : super(key: key) {
    charactersListBloc.add(GetAllCharactersEvent());
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
      body: BlocBuilder<CharactersListingBloc, CharactersListingState>(
        bloc: charactersListBloc,
        builder: (context, state) {
          if (state is CharactersListLoadedState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 36),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.charactersList.length,
                itemBuilder: (context, index) {
                  return CharacterCard(character: state.charactersList[index]);
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
