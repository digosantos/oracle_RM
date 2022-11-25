import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oracle_rm/core/characters/ui/widgets/card.dart';

import '../../../../core/favorites/domain/entities/entities.dart';
import '../../../../core/injection_container.dart';
import '../bloc/bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with CardDelegate, FavoriteButtonDelegate {
  final favoritesBloc = sl<FavoritesBloc>();

  @override
  void initState() {
    super.initState();
    favoritesBloc.add(GetFavoriteCharactersEvent());
  }

  Widget _buildEmptyComponent() {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
        child: const Text('Você não tem \npersonagens favoritos'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text('R&M Oracle'),
        backgroundColor: Colors.purple,
      ),
      body: BlocConsumer<FavoritesBloc, FavoritesState>(
        bloc: favoritesBloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FavoritesListLoadedState) {
            if (state.charactersList.isEmpty) _buildEmptyComponent();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 36),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.charactersList.length,
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
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void onPressed({required FavoriteCharacter favoriteCharacter}) {
    /// This delegate must not have any implementation once we don't
    /// want to navigate the user to character details.
  }

  @override
  void onFavoritePressed({required FavoriteCharacter favoriteCharacter}) {
    favoritesBloc.add(FavoriteTappedEvent(favoriteCharacter: favoriteCharacter));
  }
}
