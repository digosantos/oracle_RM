import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oracle_rm/core/characters/domain/entities/character.dart';
import 'package:oracle_rm/core/characters/ui/widgets/card.dart';
import 'package:oracle_rm/features/character_details/domain/usecases/get_character_details.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

import '../../../../core/common/routing/routing.dart';
import '../../../../core/injection_container.dart';

class CharactersListingPage extends StatefulWidget {
  const CharactersListingPage({Key? key}) : super(key: key);

  @override
  State<CharactersListingPage> createState() => _CharactersListingPageState();
}

class _CharactersListingPageState extends State<CharactersListingPage> with CardDelegate {
  final charactersListBloc = sl<CharactersListingBloc>();
  final PageStorageKey _pageStorageKey = const PageStorageKey('pageStorageKey');
  final _scrollController = ScrollController(initialScrollOffset: 0, keepScrollOffset: true);

  @override
  void initState() {
    super.initState();
    charactersListBloc.add(GetAllCharactersEvent());

    _scrollController.addListener(() {
      if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
        // TODO: improve UX not to return to first element
        charactersListBloc.add(GetAllCharactersEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text('R&M Oracle'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            iconSize: 28,
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<CharactersListingBloc, CharactersListingState>(
        bloc: charactersListBloc,
        buildWhen: (_, state) {
          return state is! RedirectToCharacterDetailsState;
        },
        listener: (context, state) {
          if (state is RedirectToCharacterDetailsState) {
            context.push(
              Routes.characterDetails.routeName,
              extra: RequestedCharacterParam(
                id: state.character.id,
                episodesIds: state.character.episodesIds,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CharactersListLoadedState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 36),
              child: ListView.builder(
                key: _pageStorageKey,
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.listLength,
                itemBuilder: (context, index) {
                  if (index == state.charactersList.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return CharacterCard(
                    character: state.charactersList[index],
                    cardDelegate: this,
                  );
                },
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void onPressed({required Character character}) {
    charactersListBloc.add(CharacterCardTappedEvent(character: character));
  }
}
