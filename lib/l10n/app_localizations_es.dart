// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Puntaje de Dominó';

  @override
  String get score => 'Puntaje';

  @override
  String get history => 'Historial';

  @override
  String get settings => 'Configuración';

  @override
  String get player1 => 'JUGADOR 1';

  @override
  String get player2 => 'JUGADOR 2';

  @override
  String get scoreSheetTitle => 'PUNTOS DOMINÓ';

  @override
  String get historyTitle => 'HISTORIAL';

  @override
  String get settingsTitle => 'CONFIGURACIÓN';

  @override
  String get gamePreferences => 'PREFERENCIAS DEL JUEGO';

  @override
  String get pointsToWin => 'PUNTOS PARA GANAR';

  @override
  String get pointsToWinDialogTitle => 'Puntos para ganar';

  @override
  String currentValue(Object value) {
    return 'Valor actual: $value';
  }

  @override
  String addToPlayer(Object playerName) {
    return 'SUMAR A\n$playerName';
  }

  @override
  String get restart => 'REINICIAR';

  @override
  String get undo => 'DESHACER';

  @override
  String get accept => 'ACEPTAR';

  @override
  String get cancel => 'CANCELAR';

  @override
  String get add => 'AGREGAR';

  @override
  String get howManyPoints => '¿Cuántos puntos?';

  @override
  String roundLabel(Object number) {
    return 'RONDA $number';
  }

  @override
  String victoryTitle(Object winnerName) {
    return '¡$winnerName GANA!';
  }

  @override
  String get victoryMessage =>
      'La ronda ha terminado. ¿Empezar una nueva partida?';

  @override
  String get restartConfirmation => '¿Seguro que quieres reiniciar?';

  @override
  String get undoConfirmation =>
      '¿Seguro que quieres deshacer la última ronda?';

  @override
  String get noGamesYet => 'Aún no hay partidas completadas';

  @override
  String gameNumber(Object number) {
    return 'PARTIDA $number';
  }

  @override
  String winner(Object winnerName) {
    return 'GANADOR: $winnerName';
  }

  @override
  String get defaultPointsHint => '100';
}
