import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../l10n/generated/app_localizations.dart';
import 'locale_controller.dart';

/// Kurdish (ckb) has no built-in Material/Cupertino translations in Flutter,
/// so it reuses Arabic — it shares the Arabic script and RTL directionality.
class KurdishMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const KurdishMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LocaleController.supportedLocales.contains(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    final target =
        locale.languageCode == 'ckb' ? const Locale('ar') : locale;
    return GlobalMaterialLocalizations.delegate.load(target);
  }

  @override
  bool shouldReload(covariant KurdishMaterialLocalizationsDelegate old) =>
      false;
}

class KurdishCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const KurdishCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LocaleController.supportedLocales.contains(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    final target =
        locale.languageCode == 'ckb' ? const Locale('ar') : locale;
    return GlobalCupertinoLocalizations.delegate.load(target);
  }

  @override
  bool shouldReload(covariant KurdishCupertinoLocalizationsDelegate old) =>
      false;
}

/// Provides text direction for the app's locales. Kurdish (ckb) is RTL.
class KurdishWidgetsLocalizations implements WidgetsLocalizations {
  const KurdishWidgetsLocalizations(this.textDirection);

  @override
  final TextDirection textDirection;
}

class KurdishWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const KurdishWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      LocaleController.supportedLocales.contains(locale);

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    return SynchronousFuture<WidgetsLocalizations>(
      KurdishWidgetsLocalizations(
        locale.languageCode == 'ckb' ? TextDirection.rtl : TextDirection.ltr,
      ),
    );
  }

  @override
  bool shouldReload(covariant KurdishWidgetsLocalizationsDelegate old) =>
      false;
}