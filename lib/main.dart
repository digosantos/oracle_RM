import 'package:flutter/material.dart';
import 'package:oracle_rm/core/injection_container.dart' as di;

import './features/characters_listing/ui/pages/pages.dart';

void main() {
  di.init();
  runApp(const RickAndMortyOracleApp());
}

class RickAndMortyOracleApp extends StatelessWidget {
  const RickAndMortyOracleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'R&M Oracle',
      home: CharactersListingPage(),
    );
  }
}
