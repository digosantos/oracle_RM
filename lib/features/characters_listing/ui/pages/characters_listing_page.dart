import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: AppBar(
        title: const Text('R&M Oracle'),
      ),
      body: BlocBuilder<CharactersListingBloc, CharactersListingState>(
        bloc: charactersListBloc,
        builder: (context, state) {
          if (state is CharactersListLoadedState) {
            return Center(
                child: Text(
                    'Amount of characters: ${state.charactersList.length}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
