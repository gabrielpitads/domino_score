// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Domino Score';

  @override
  String get score => 'Score';

  @override
  String get history => 'History';

  @override
  String get settings => 'Settings';

  @override
  String get player1 => 'PLAYER 1';

  @override
  String get player2 => 'PLAYER 2';

  @override
  String get scoreSheetTitle => 'DOMINO SCORE';

  @override
  String get historyTitle => 'HISTORY';

  @override
  String get settingsTitle => 'SETTINGS';

  @override
  String get gamePreferences => 'GAME PREFERENCES';

  @override
  String get pointsToWin => 'POINTS TO WIN';

  @override
  String get pointsToWinDialogTitle => 'Points to win';

  @override
  String currentValue(Object value) {
    return 'Current value: $value';
  }

  @override
  String addToPlayer(Object playerName) {
    return 'ADD TO $playerName';
  }

  @override
  String get restart => 'RESTART';

  @override
  String get undo => 'UNDO';

  @override
  String get accept => 'ACCEPT';

  @override
  String get cancel => 'CANCEL';

  @override
  String get add => 'ADD';

  @override
  String get howManyPoints => 'How many points?';

  @override
  String roundLabel(Object number) {
    return 'ROUND $number';
  }

  @override
  String victoryTitle(Object winnerName) {
    return '$winnerName WINS!';
  }

  @override
  String get victoryMessage => 'The round is over. Start a new game?';

  @override
  String get restartConfirmation => 'Are you sure you want to restart?';

  @override
  String get undoConfirmation =>
      'Are you sure you want to undo the last round?';

  @override
  String get noGamesYet => 'No completed games yet';

  @override
  String gameNumber(Object number) {
    return 'GAME $number';
  }

  @override
  String winner(Object winnerName) {
    return 'WINNER: $winnerName';
  }

  @override
  String get defaultPointsHint => '100';
}
