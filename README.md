# Domino Score

Domino Score is a Flutter mobile app for tracking domino scoring between two players. It provides a polished score sheet experience with modal-based score entry, undo and restart actions, victory detection, and a local game history screen.

## Features

- Two-player score tracking with a dedicated score sheet UI
- Modal input for adding custom point values to a player
- Undo and restart actions with confirmation dialogs
- Victory detection at 100 points or more with a winner modal
- Persistent history of completed games stored locally for the last 20 games
- Bottom navigation between Score, History, and Settings

## Project Structure

- lib/main.dart: app entry point and theme setup
- lib/screens/score_sheet.dart: main score tracking screen
- lib/screens/history_screen.dart: completed game history view
- lib/screens/settings_screen.dart: app settings screen
- lib/services/game_history.dart: local persistence for game history

## Getting Started

1. Install Flutter and ensure your environment is configured.
2. Clone the repository and navigate to the project folder.
3. Run the following commands:

```bash
flutter pub get
flutter run
```

## Testing

Run the test suite with:

```bash
flutter test
```
