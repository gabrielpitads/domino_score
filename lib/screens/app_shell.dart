import 'package:domino_score/screens/history_screen.dart';
import 'package:domino_score/screens/score_sheet.dart';
import 'package:domino_score/screens/settings_screen.dart';
import 'package:domino_score/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ScoreSheetScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF131313),
        indicatorColor: const Color(0xFF1C1B1B),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.score), label: l10n.score),
          NavigationDestination(icon: const Icon(Icons.history), label: l10n.history),
          NavigationDestination(icon: const Icon(Icons.settings), label: l10n.settings),
        ],
      ),
    );
  }
}
