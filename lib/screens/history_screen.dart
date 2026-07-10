import 'package:domino_score/services/game_history.dart';
import 'package:domino_score/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    GameHistoryService.instance.load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131313),
        foregroundColor: const Color(0xFFCDFFDC),
        title: Text(
          l10n.historyTitle,
          style: TextStyle(
            color: Color(0xFFCDFFDC),
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.02,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: ValueListenableBuilder<List<GameHistoryEntry>>(
        valueListenable: GameHistoryService.instance.entries,
        builder: (context, entries, _) {
          if (entries.isEmpty) {
            return Center(
              child: Text(
                l10n.noGamesYet,
                style: const TextStyle(color: Color(0xFFB9CCBD)),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: entries.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF201F1F),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF3B4A3F)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.gameNumber(entries.length - index),
                      style: const TextStyle(
                        color: Color(0xFFCDFFDC),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${entry.player1Name}: ${entry.player1Score}',
                      style: const TextStyle(color: Color(0xFFB9CCBD)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${entry.player2Name}: ${entry.player2Score}',
                      style: const TextStyle(color: Color(0xFFB9CCBD)),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.winner(entry.winnerName),
                      style: const TextStyle(
                        color: Color(0xFF00f59b),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
