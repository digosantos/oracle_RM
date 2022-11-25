import 'package:go_router/go_router.dart';
import 'package:oracle_rm/core/common/routing/routing.dart';
import 'package:oracle_rm/features/character_details/domain/usecases/usecases.dart';

import '../../../features/character_details/ui/pages/pages.dart';
import '../../../features/characters_listing/ui/pages/pages.dart';

class AppRouter {
  GoRouter buildRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          path: Routes.root.routeName,
          builder: (context, state) => const CharactersListingPage(),
        ),
        GoRoute(
          path: Routes.charactersListing.routeName,
          builder: (context, state) => const CharactersListingPage(),
        ),
        GoRoute(
          path: Routes.characterDetails.routeName,
          builder: (context, state) {
            return CharacterDetailsPage(
              requestedCharacterParam: state.extra as RequestedCharacterParam,
            );
          },
        ),
      ],
    );
  }
}
