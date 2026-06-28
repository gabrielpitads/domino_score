import 'package:domino_score/screens/app_shell.dart';
import 'package:domino_score/services/game_history.dart';
import 'package:domino_score/services/settings_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GameHistoryService.instance.init();
  await SettingsService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domino Score',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00f59b),
          brightness: Brightness.dark,
        ),
      ),
      home: const AppShell(),
    );
  }
}
