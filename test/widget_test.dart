// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:domino_score/main.dart';
import 'package:domino_score/services/game_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });
  testWidgets('shows the domino score sheet UI', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('DOMINO SCORE'), findsOneWidget);
    expect(find.text('PLAYER 1'), findsOneWidget);
    expect(find.text('PLAYER 2'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('uses Spanish strings when a Spanish locale is provided', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp(locale: Locale('es')));

    expect(find.text('PUNTUACIÓN DOMINÓ'), findsOneWidget);
    expect(find.text('Puntaje'), findsOneWidget);
    expect(find.text('Configuración'), findsOneWidget);
  });

  testWidgets('shows the settings entry for points to win', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('SETTINGS'), findsOneWidget);
    expect(find.text('POINTS TO WIN'), findsOneWidget);
    expect(find.text('Current value: 100'), findsOneWidget);
  });

  testWidgets('opens a numeric dialog and adds a round entry', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('ADD TO PLAYER 1'));
    await tester.pumpAndSettle();

    expect(find.text('How many points?'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '25');
    await tester.tap(find.text('ADD'));
    await tester.pumpAndSettle();

    expect(find.text('ROUND 1'), findsOneWidget);
    expect(find.text('+25'), findsOneWidget);
  });

  testWidgets(
    'undoes the latest entry from whichever player was updated last',
    (tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('ADD TO PLAYER 1'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '10');
      await tester.tap(find.text('ADD'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('ADD TO PLAYER 2'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '25');
      await tester.tap(find.text('ADD'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('UNDO'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('ACCEPT'));
      await tester.pumpAndSettle();

      expect(find.text('+25'), findsNothing);
      expect(find.text('10'), findsOneWidget);
    },
  );

  testWidgets('cancelling undo leaves the round history intact', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('ADD TO PLAYER 1'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '10');
    await tester.tap(find.text('ADD'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('UNDO'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CANCEL'));
    await tester.pumpAndSettle();

    expect(find.text('+10'), findsOneWidget);
  });

  testWidgets('accepting restart clears the score state', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('ADD TO PLAYER 1'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '10');
    await tester.tap(find.text('ADD'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('RESTART'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ACCEPT'));
    await tester.pumpAndSettle();

    expect(find.text('0'), findsWidgets);
    expect(find.text('+10'), findsNothing);
  });

  testWidgets('cancelling restart leaves the score state intact', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('ADD TO PLAYER 1'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '10');
    await tester.tap(find.text('ADD'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('RESTART'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CANCEL'));
    await tester.pumpAndSettle();

    expect(find.text('+10'), findsOneWidget);
  });

  testWidgets('shows a victory dialog when a player reaches the configured threshold', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('ADD TO PLAYER 1'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '100');
    await tester.tap(find.text('ADD'));
    await tester.pumpAndSettle();

    expect(find.text('PLAYER 1 WINS!'), findsOneWidget);
  });

  testWidgets('persists a completed game in history', (tester) async {
    await GameHistoryService.instance.clear();
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('ADD TO PLAYER 1'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '100');
    await tester.tap(find.text('ADD'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ACCEPT'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('History'));
    await tester.pumpAndSettle();

    expect(find.text('WINNER: PLAYER 1'), findsOneWidget);
    expect(find.text('PLAYER 1: 100'), findsOneWidget);
    expect(find.text('PLAYER 2: 0'), findsOneWidget);
  });
}
