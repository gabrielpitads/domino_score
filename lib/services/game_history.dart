import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameHistoryEntry {
  const GameHistoryEntry({
    required this.player1Name,
    required this.player1Score,
    required this.player2Name,
    required this.player2Score,
    required this.winnerName,
    required this.completedAt,
  });

  final String player1Name;
  final int player1Score;
  final String player2Name;
  final int player2Score;
  final String winnerName;
  final DateTime completedAt;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'player1Name': player1Name,
      'player1Score': player1Score,
      'player2Name': player2Name,
      'player2Score': player2Score,
      'winnerName': winnerName,
      'completedAt': completedAt.toIso8601String(),
    };
  }

  factory GameHistoryEntry.fromJson(Map<String, dynamic> json) {
    return GameHistoryEntry(
      player1Name: json['player1Name'] as String,
      player1Score: json['player1Score'] as int,
      player2Name: json['player2Name'] as String,
      player2Score: json['player2Score'] as int,
      winnerName: json['winnerName'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String),
    );
  }
}

class GameHistoryService {
  GameHistoryService._();

  static final GameHistoryService instance = GameHistoryService._();

  static const String _storageKey = 'game_history';
  static const int _maxEntries = 20;

  final ValueNotifier<List<GameHistoryEntry>> entries =
      ValueNotifier<List<GameHistoryEntry>>(<GameHistoryEntry>[]);

  bool _loaded = false;

  Future<void> init() async {
    await load();
  }

  Future<void> load() async {
    if (_loaded) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final serialized = prefs.getStringList(_storageKey) ?? <String>[];
    final parsed = serialized
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .map(GameHistoryEntry.fromJson)
        .toList(growable: false);

    entries.value = parsed;
    _loaded = true;
  }

  Future<void> addGameResult({
    required String player1Name,
    required int player1Score,
    required String player2Name,
    required int player2Score,
    required String winnerName,
  }) async {
    await _ensureLoaded();

    final updated = <GameHistoryEntry>[
      GameHistoryEntry(
        player1Name: player1Name,
        player1Score: player1Score,
        player2Name: player2Name,
        player2Score: player2Score,
        winnerName: winnerName,
        completedAt: DateTime.now(),
      ),
      ...entries.value,
    ];

    if (updated.length > _maxEntries) {
      updated.removeRange(_maxEntries, updated.length);
    }

    entries.value = updated;
    await _persist(updated);
  }

  Future<void> clear() async {
    await _ensureLoaded();
    entries.value = <GameHistoryEntry>[];
    await _persist(<GameHistoryEntry>[]);
  }

  Future<void> _ensureLoaded() async {
    if (!_loaded) {
      await load();
    }
  }

  Future<void> _persist(List<GameHistoryEntry> history) async {
    final prefs = await SharedPreferences.getInstance();
    final serialized = history
        .map((entry) => jsonEncode(entry.toJson()))
        .toList(growable: false);
    await prefs.setStringList(_storageKey, serialized);
  }
}
