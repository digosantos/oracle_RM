import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oracle_rm/core/characters/ui/widgets/card.dart';
import 'package:oracle_rm/core/characters/ui/widgets/favorite_button.dart';
import 'package:oracle_rm/core/favorites/domain/entities/favorite_character.dart';
import 'package:oracle_rm/features/character_details/domain/usecases/get_character_details.dart';
import 'package:oracle_rm/features/character_details/ui/bloc/bloc.dart';

import '../../../../core/common/ui/text_styles.dart';
import '../../../../core/injection_container.dart';

class CharacterDetailsPage extends StatelessWidget with FavoriteButtonDelegate {
  final RequestedCharacterParam requestedCharacterParam;

  final characterDetailsBloc = sl<CharacterDetailsBloc>();
  TextStyle get subtitle18 => sl<TextStyles>().subtitle18;
  TextStyle get text16 => sl<TextStyles>().text16;

  CharacterDetailsPage({Key? key, required this.requestedCharacterParam}) : super(key: key) {
    characterDetailsBloc.add(GetCharacterDetailsEvent(requestedCharacter: requestedCharacterParam));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text('R&M Oracle'),
        backgroundColor: Colors.purple,
      ),
      body: BlocConsumer<CharacterDetailsBloc, CharacterDetailsState>(
        listener: (_, __) {},
        bloc: characterDetailsBloc,
        builder: (context, state) {
          if (state is DetailsLoadedState) {
            final characterDetails = state.characterDetails;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: ListView(
                shrinkWrap: true,
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
                  Align(
                    alignment: Alignment.center,
                    child: FavoriteButton(
                      favoriteCharacter: state.favoriteCharacter,
                      favoriteButtonDelegate: this,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status: ${characterDetails.status}',
                        textAlign: TextAlign.center,
                        style: subtitle18,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Espécie: ${characterDetails.species}',
                        textAlign: TextAlign.center,
                        style: subtitle18,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Origem: ${characterDetails.origin}',
                        textAlign: TextAlign.center,
                        style: subtitle18,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Localização: ${characterDetails.location}',
                        textAlign: TextAlign.center,
                        style: subtitle18,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Criação: ${characterDetails.createdAt}',
                        textAlign: TextAlign.center,
                        style: subtitle18,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Lista de Episódios:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.characterDetails.episodes.length,
                        itemBuilder: (context, index) {
                          final episode = state.characterDetails.episodes[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(episode.name, style: text16),
                                Text(episode.airDate, style: text16),
                              ],
                            ),
                          );
                        },
                      ),
                      Text(
                        'Total de Episódios: ${characterDetails.episodesIds.length.toString()}',
                        textAlign: TextAlign.center,
                        style: subtitle18,
                      ),
                    ],
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

  @override
  void onFavoritePressed({required FavoriteCharacter favoriteCharacter}) {
    characterDetailsBloc.add(FavoriteCharacterDetailsTappedEvent(favoriteCharacter: favoriteCharacter));
  }
}
