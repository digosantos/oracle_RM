import 'package:flutter/material.dart';
import 'package:oracle_rm/core/common/routing/router.dart';
import 'package:oracle_rm/core/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(RickAndMortyOracleApp());
}

class RickAndMortyOracleApp extends StatelessWidget {
  RickAndMortyOracleApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'R&M Oracle',
      routerConfig: _appRouter.buildRouter(),
    );
  }
}
