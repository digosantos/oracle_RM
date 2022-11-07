import 'package:flutter/material.dart';

void main() {
  runApp(const RickAndMortyOracleApp());
}

class RickAndMortyOracleApp extends StatelessWidget {
  const RickAndMortyOracleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'R&M Oracle',
      home: SizedBox.shrink(),
    );
  }
}
