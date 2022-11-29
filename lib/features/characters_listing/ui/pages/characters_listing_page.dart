import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oracle_rm/core/characters/ui/widgets/card.dart';
import 'package:oracle_rm/features/characters_listing/ui/bloc/bloc.dart';

import '../../../../core/common/routing/routing.dart';
import '../../../../core/favorites/domain/entities/entities.dart';
import '../../../../core/injection_container.dart';
import '../../domain/usecases/usecases.dart';

class CharactersListingPage extends StatefulWidget {
  const CharactersListingPage({Key? key}) : super(key: key);

  @override
  State<CharactersListingPage> createState() => _CharactersListingPageState();
}

class _CharactersListingPageState extends State<CharactersListingPage>
    with CardDelegate, FavoriteButtonDelegate {
  final charactersListBloc = sl<CharactersListingBloc>();
  final PageStorageKey _pageStorageKey = const PageStorageKey('pageStorageKey');
  final _scrollController = ScrollController();
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    charactersListBloc.add(const GetAllCharactersEvent());

    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        // TODO: improve UX not to return to first element
        charactersListBloc.add(const GetAllCharactersEvent());
      }
    });
  }

  final List<bool> _toggleStates = [true, false];

  Widget _buildSearchToggle() {
    return ToggleButtons(
      selectedColor: Colors.white,
      selectedBorderColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      borderColor: Colors.purple,
      color: Colors.black,
      disabledColor: Colors.black,
      fillColor: Colors.purple,
      isSelected: _toggleStates,
      onPressed: (index) => _updateToggles(index: index),
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            'Nome',
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Espécie'),
        ),
      ],
    );
  }

  void _updateToggles({required int index}) {
    setState(() {
      /// Verify if any toggle is enabled already
      final trueIndex = _toggleStates.indexWhere((element) => element == true);
      if (trueIndex != -1) _toggleStates[trueIndex] = false;
      _toggleStates[index] = !_toggleStates[index];
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
            onPressed: () => charactersListBloc.add(FavoritesTappedEvent()),
          ),
        ],
      ),
      body: BlocConsumer<CharactersListingBloc, CharactersListingState>(
        bloc: charactersListBloc,
        buildWhen: (_, state) {
          return state is! RedirectToCharacterDetailsState &&
              state is! RedirectToFavoritesState;
        },
        listener: (context, state) {
          if (state is RedirectToCharacterDetailsState) {
            context.push(
              Routes.characterDetails.routeName,
              extra: RequestedCharacterParam(
                favoriteCharacter: state.favoriteCharacter,
                episodesIds: state.favoriteCharacter.character.episodesIds,
              ),
            );
          }

          if (state is RedirectToFavoritesState) {
            context.push(Routes.favorites.routeName);
          }
        },
        builder: (context, state) {
          if (state is CharactersListLoadedState) {
            return Column(
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchTextController,
                        onChanged: (value) {
                          Filter? filter;

                          if (value.isEmpty) {
                            filter = null;
                          } else {
                            final selectedIndex = _toggleStates
                                .indexWhere((element) => element == true);
                            filter = Filter(
                              filterType: (selectedIndex == 0)
                                  ? FilterType.name
                                  : FilterType.species,
                              searchText: value,
                            );
                          }

                          charactersListBloc
                              .add(GetAllCharactersEvent(filter: filter));
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Procure por nome ou espécie',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Colors.purple, width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildSearchToggle(),
                    ],
                  ),
                ),
                Expanded(
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
                        favoriteCharacter: state.charactersList[index],
                        cardDelegate: this,
                        favoriteButtonDelegate: this,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void onPressed({required FavoriteCharacter favoriteCharacter}) {
    charactersListBloc
        .add(CharacterCardTappedEvent(favoriteCharacter: favoriteCharacter));
  }

  @override
  void onFavoritePressed({required FavoriteCharacter favoriteCharacter}) {
    charactersListBloc.add(
        FavoriteCharacterTappedEvent(favoriteCharacter: favoriteCharacter));
  }
}
