import 'package:domino_score/l10n/app_localizations.dart';
import 'package:domino_score/services/game_history.dart';
import 'package:domino_score/services/settings_service.dart';
import 'package:flutter/material.dart';

class ScoreSheetScreen extends StatefulWidget {
  const ScoreSheetScreen({super.key});

  @override
  State<ScoreSheetScreen> createState() => _ScoreSheetScreenState();
}

class _RoundEntry {
  const _RoundEntry({required this.label, required this.value});

  final String label;
  final int value;
}

class _PlayerScoreState {
  _PlayerScoreState({required this.name, required this.initialScore}) {
    score = initialScore;
  }

  final String name;
  final int initialScore;
  late int score;
  final List<_RoundEntry> history = <_RoundEntry>[];
}

class _ScoreEvent {
  const _ScoreEvent({required this.playerIndex, required this.entry});

  final int playerIndex;
  final _RoundEntry entry;
}

class _ScoreSheetScreenState extends State<ScoreSheetScreen> {
  late final List<_PlayerScoreState> _players;
  late final List<_ScoreEvent> _actionHistory;

  @override
  void initState() {
    super.initState();
    _players = <_PlayerScoreState>[];
    _actionHistory = <_ScoreEvent>[];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_players.isNotEmpty) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    _players.addAll(<_PlayerScoreState>[
      _PlayerScoreState(name: l10n.player1, initialScore: 0),
      _PlayerScoreState(name: l10n.player2, initialScore: 0),
    ]);
  }

  Future<void> _showVictoryDialog(String winnerName) async {
    final l10n = AppLocalizations.of(context)!;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF201F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          title: Text(
            l10n.victoryTitle(winnerName),
            style: const TextStyle(
              color: Color(0xFFCDFFDC),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            l10n.victoryMessage,
            style: const TextStyle(color: Color(0xFFB9CCBD)),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00f59b),
                foregroundColor: const Color(0xFF003920),
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await GameHistoryService.instance.addGameResult(
                  player1Name: _players[0].name,
                  player1Score: _players[0].score,
                  player2Name: _players[1].name,
                  player2Score: _players[1].score,
                  winnerName: winnerName,
                );
                setState(() {
                  for (final player in _players) {
                    player.score = player.initialScore;
                    player.history.clear();
                  }
                  _actionHistory.clear();
                });
              },
              child: Text(l10n.accept),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addToPlayer(int index) async {
    final l10n = AppLocalizations.of(context)!;
    final player = _players[index];
    final controller = TextEditingController();

    final value = await showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF201F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          title: Text(
            l10n.howManyPoints,
            style: const TextStyle(
              color: Color(0xFFCDFFDC),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            style: const TextStyle(color: Color(0xFFCDFFDC)),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: const TextStyle(color: Color(0xFF8FA08F)),
              filled: true,
              fillColor: const Color(0xFF161616),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF00f59b)),
              ),
            ),
            onSubmitted: (_) {
              Navigator.of(dialogContext).pop(int.tryParse(controller.text));
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                l10n.cancel,
                style: const TextStyle(color: Color(0xFFB9CCBD)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00f59b),
                foregroundColor: const Color(0xFF003920),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(int.tryParse(controller.text));
              },
              child: Text(l10n.add),
            ),
          ],
        );
      },
    );

    if (value == null || value <= 0) {
      return;
    }

    setState(() {
      final entry = _RoundEntry(
        label: l10n.roundLabel(player.history.length + 1),
        value: value,
      );
      player.score += value;
      player.history.insert(0, entry);
      _actionHistory.add(_ScoreEvent(playerIndex: index, entry: entry));
    });

    if (player.score >= SettingsService.instance.pointsToWin) {
      await _showVictoryDialog(player.name);
    }
  }

  Future<void> _restartScores() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF201F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          title: Text(
            l10n.restartConfirmation,
            style: const TextStyle(
              color: Color(0xFFCDFFDC),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                l10n.cancel,
                style: const TextStyle(color: Color(0xFFB9CCBD)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00f59b),
                foregroundColor: const Color(0xFF003920),
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.accept),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    setState(() {
      for (final player in _players) {
        player.score = player.initialScore;
        player.history.clear();
      }
      _actionHistory.clear();
    });
  }

  Future<void> _undoLastEntry() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF201F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          title: Text(
            l10n.undoConfirmation,
            style: const TextStyle(
              color: Color(0xFFCDFFDC),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                l10n.cancel,
                style: const TextStyle(color: Color(0xFFB9CCBD)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00f59b),
                foregroundColor: const Color(0xFF003920),
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.accept),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    setState(() {
      if (_actionHistory.isEmpty) {
        return;
      }

      final lastEvent = _actionHistory.removeLast();
      final player = _players[lastEvent.playerIndex];
      player.score -= lastEvent.entry.value;
      player.history.removeWhere((entry) => identical(entry, lastEvent.entry));
    });
  }

  Widget _buildPlayerCard(int index) {
    final l10n = AppLocalizations.of(context)!;
    final player = _players[index];
    const accentColor = Color(0xFF00f59b);
    const secondaryTextColor = Color(0xFFB9CCBD);
    const primaryTextColor = Color(0xFFCDFFDC);

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF201F1F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () => _addToPlayer(index),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        player.name,
                        style: const TextStyle(
                          color: primaryTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.05,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    player.score.toString(),
                    style: const TextStyle(
                      color: primaryTextColor,
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                      height: 1,
                      letterSpacing: -0.04,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 4,
                    width: 32,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: const [
                        BoxShadow(color: Color(0x4D00F59B), blurRadius: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFF3B4A3F)),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: player.history.length,
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                itemBuilder: (context, itemIndex) {
                  final entry = player.history[itemIndex];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.label,
                        style: const TextStyle(
                          color: secondaryTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                      Text(
                        '+${entry.value}',
                        style: const TextStyle(
                          color: primaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _addToPlayer(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: const Color(0xFF003920),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_circle, size: 18),
                      const SizedBox(width: 8),
                      Text(l10n.addToPlayer(player.name)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131313),
        title: Text(
          l10n.scoreSheetTitle,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildPlayerCard(0),
                    const SizedBox(width: 12),
                    _buildPlayerCard(1),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _restartScores,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFB7B5B4),
                        side: const BorderSide(color: Color(0xFF3B4A3F)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.refresh),
                      label: Text(l10n.restart),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _undoLastEntry,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFB7B5B4),
                        side: const BorderSide(color: Color(0xFF3B4A3F)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.undo),
                      label: Text(l10n.undo),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
