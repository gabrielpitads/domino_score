import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Domino Score'**
  String get appTitle;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @player1.
  ///
  /// In en, this message translates to:
  /// **'PLAYER 1'**
  String get player1;

  /// No description provided for @player2.
  ///
  /// In en, this message translates to:
  /// **'PLAYER 2'**
  String get player2;

  /// No description provided for @scoreSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'DOMINO SCORE'**
  String get scoreSheetTitle;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'HISTORY'**
  String get historyTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsTitle;

  /// No description provided for @gamePreferences.
  ///
  /// In en, this message translates to:
  /// **'GAME PREFERENCES'**
  String get gamePreferences;

  /// No description provided for @pointsToWin.
  ///
  /// In en, this message translates to:
  /// **'POINTS TO WIN'**
  String get pointsToWin;

  /// No description provided for @pointsToWinDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Points to win'**
  String get pointsToWinDialogTitle;

  /// No description provided for @currentValue.
  ///
  /// In en, this message translates to:
  /// **'Current value: {value}'**
  String currentValue(Object value);

  /// No description provided for @addToPlayer.
  ///
  /// In en, this message translates to:
  /// **'ADD TO {playerName}'**
  String addToPlayer(Object playerName);

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'RESTART'**
  String get restart;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'UNDO'**
  String get undo;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'ACCEPT'**
  String get accept;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'ADD'**
  String get add;

  /// No description provided for @howManyPoints.
  ///
  /// In en, this message translates to:
  /// **'How many points?'**
  String get howManyPoints;

  /// No description provided for @roundLabel.
  ///
  /// In en, this message translates to:
  /// **'ROUND {number}'**
  String roundLabel(Object number);

  /// No description provided for @victoryTitle.
  ///
  /// In en, this message translates to:
  /// **'{winnerName} WINS!'**
  String victoryTitle(Object winnerName);

  /// No description provided for @victoryMessage.
  ///
  /// In en, this message translates to:
  /// **'The round is over. Start a new game?'**
  String get victoryMessage;

  /// No description provided for @restartConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to restart?'**
  String get restartConfirmation;

  /// No description provided for @undoConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to undo the last round?'**
  String get undoConfirmation;

  /// No description provided for @noGamesYet.
  ///
  /// In en, this message translates to:
  /// **'No completed games yet'**
  String get noGamesYet;

  /// No description provided for @gameNumber.
  ///
  /// In en, this message translates to:
  /// **'GAME {number}'**
  String gameNumber(Object number);

  /// No description provided for @winner.
  ///
  /// In en, this message translates to:
  /// **'WINNER: {winnerName}'**
  String winner(Object winnerName);

  /// No description provided for @defaultPointsHint.
  ///
  /// In en, this message translates to:
  /// **'100'**
  String get defaultPointsHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
