import 'package:flutter/material.dart';

import '../core/l10n/locale_controller.dart';
import '../l10n/generated/app_localizations.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  Future<void> _pick(BuildContext context) async {
    final current = Localizations.localeOf(context);
    final selected = await showModalBottomSheet<Locale>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.language_rounded),
              title: Text(AppLocalizations.of(ctx).language),
              subtitle: const Text('English / کوردی'),
            ),
            const Divider(height: 1),
            ListTile(
              leading: Icon(
                Icons.check_circle_rounded,
                color: current.languageCode == 'en'
                    ? Theme.of(ctx).colorScheme.primary
                    : Colors.transparent,
              ),
              title: const Text('English'),
              subtitle: Text(AppLocalizations.of(ctx).languageEnglish),
              onTap: () => Navigator.pop(
                ctx,
                const Locale('en'),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.check_circle_rounded,
                color: current.languageCode == 'ckb'
                    ? Theme.of(ctx).colorScheme.primary
                    : Colors.transparent,
              ),
              title: const Text('کوردی'),
              subtitle: Text(AppLocalizations.of(ctx).languageKurdish),
              onTap: () => Navigator.pop(ctx, const Locale('ckb')),
            ),
          ],
        ),
      ),
    );
    if (selected != null) {
      await LocaleController.instance.setLocale(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context).language,
      icon: const Icon(Icons.language_rounded),
      onPressed: () => _pick(context),
    );
  }
}