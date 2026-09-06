import 'package:flutter/material.dart';

import '../core/theme/theme_controller.dart';
import '../l10n/generated/app_localizations.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  Future<void> _pick(BuildContext context) async {
    final current = ThemeController.instance.mode.value;
    final selected = await showModalBottomSheet<ThemeMode>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.brightness_auto_rounded),
              title: Text(AppLocalizations.of(ctx).theme),
              subtitle: Text(AppLocalizations.of(ctx).themeSubtitle),
            ),
            const Divider(height: 1),
            _option(
              ctx,
              AppLocalizations.of(ctx).themeSystem,
              Icons.brightness_auto_rounded,
              ThemeMode.system,
              current,
            ),
            _option(
              ctx,
              AppLocalizations.of(ctx).themeLight,
              Icons.light_mode_rounded,
              ThemeMode.light,
              current,
            ),
            _option(
              ctx,
              AppLocalizations.of(ctx).themeDark,
              Icons.dark_mode_rounded,
              ThemeMode.dark,
              current,
            ),
          ],
        ),
      ),
    );
    if (selected != null) {
      await ThemeController.instance.setMode(selected);
    }
  }

  Widget _option(
    BuildContext ctx,
    String label,
    IconData icon,
    ThemeMode value,
    ThemeMode current,
  ) {
    final theme = Theme.of(ctx);
    return ListTile(
      leading: Icon(icon, color: value == current ? theme.colorScheme.primary : null),
      title: Text(label),
      trailing: Icon(
        Icons.check_rounded,
        color: value == current ? theme.colorScheme.primary : Colors.transparent,
      ),
      onTap: () => Navigator.pop(ctx, value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.mode,
      builder: (context, mode, _) => IconButton(
        tooltip: AppLocalizations.of(context).theme,
        icon: mode == ThemeMode.system
            ? const Icon(Icons.brightness_auto_rounded)
            : Icon(dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
        onPressed: () => _pick(context),
      ),
    );
  }
}