import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController {
  LocaleController._();

  static final LocaleController instance = LocaleController._();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ckb'),
  ];

  static const String _prefKey = 'app_locale';

  final ValueNotifier<Locale> locale = ValueNotifier<Locale>(const Locale('en'));

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefKey);
    locale.value = code == 'ckb' ? const Locale('ckb') : const Locale('en');
  }

  Future<void> setLocale(Locale newLocale) async {
    locale.value = newLocale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, newLocale.languageCode);
  }
}