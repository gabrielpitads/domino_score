import 'package:domino_score/services/settings_service.dart';
import 'package:domino_score/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _pointsToWin = SettingsService.instance.pointsToWin;

  Future<void> _openPointsDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: _pointsToWin.toString());

    final accepted = await showDialog<bool>(
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
            l10n.pointsToWinDialogTitle,
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
              hintText: l10n.defaultPointsHint,
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
              Navigator.of(
                dialogContext,
              ).pop(int.tryParse(controller.text) != null);
            },
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
              onPressed: () {
                Navigator.of(
                  dialogContext,
                ).pop(int.tryParse(controller.text) != null);
              },
              child: Text(l10n.accept),
            ),
          ],
        );
      },
    );

    if (accepted != true) {
      return;
    }

    final parsedValue = int.tryParse(controller.text);
    if (parsedValue == null || parsedValue <= 0) {
      return;
    }

    await SettingsService.instance.setPointsToWin(parsedValue);
    setState(() {
      _pointsToWin = parsedValue;
    });
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
          l10n.settingsTitle,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.gamePreferences,
                style: const TextStyle(
                  color: Color(0xFF8FA08F),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.16,
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _openPointsDialog,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF201F1F),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF3B4A3F)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.pointsToWin,
                              style: const TextStyle(
                                color: Color(0xFFCDFFDC),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n.currentValue(_pointsToWin),
                              style: const TextStyle(
                                color: Color(0xFFB9CCBD),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Color(0xFF00f59b)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
