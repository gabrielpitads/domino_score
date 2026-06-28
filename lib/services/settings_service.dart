import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  SettingsService._();

  static final SettingsService instance = SettingsService._();

  static const String _pointsToWinKey = 'points_to_win';
  static const int _defaultPointsToWin = 100;

  int _pointsToWin = _defaultPointsToWin;

  int get pointsToWin => _pointsToWin;

  Future<void> init() async {
    await _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _pointsToWin = prefs.getInt(_pointsToWinKey) ?? _defaultPointsToWin;
  }

  Future<void> setPointsToWin(int value) async {
    final prefs = await SharedPreferences.getInstance();
    _pointsToWin = value;
    await prefs.setInt(_pointsToWinKey, value);
  }
}
