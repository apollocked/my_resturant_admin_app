import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

const Color kAccent = AppColors.primary;
const Color kSuccess = AppColors.success;
const Color kWarning = AppColors.warning;
const Color kDanger = AppColors.error;
const Color kInfo = AppColors.info;

const PageTransitionsTheme _pageTransitions = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
    TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
    TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
    TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
  },
);

ThemeData buildTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final bg = dark ? const Color(0xFF121212) : AppColors.background;
  final surface = dark ? const Color(0xFF1E1E1E) : AppColors.surface;

  return ThemeData(
    fontFamily: 'NRT',
    useMaterial3: true,
    brightness: brightness,
    splashFactory: InkSparkle.splashFactory,
    pageTransitionsTheme: _pageTransitions,
    scaffoldBackgroundColor: bg,
    colorScheme: dark
        ? const ColorScheme.dark(
            primary: AppColors.primary,
            secondary: AppColors.primary,
            surface: Color(0xFF1E1E1E),
            error: AppColors.error,
          )
        : const ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.primary,
            surface: AppColors.surface,
            error: AppColors.error,
          ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      backgroundColor: surface,
      surfaceTintColor: Colors.transparent,
      foregroundColor: dark ? Colors.white : AppColors.textPrimary,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: dark ? Colors.white : AppColors.textPrimary,
      ),
      iconTheme: IconThemeData(color: dark ? Colors.white : AppColors.textPrimary),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: surface,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: dark ? Colors.white : AppColors.textPrimary,
        minimumSize: const Size(0, 48),
        side: BorderSide(color: dark ? const Color(0xFF2E2E2E) : AppColors.divider),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: dark ? const Color(0xFF2A2A2A) : const Color(0xFFF7F5F3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: TextStyle(color: dark ? const Color(0xFF8C8C8E) : AppColors.textSecondary, fontSize: 13),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(color: dark ? const Color(0xFF2E2E2E) : AppColors.divider),
      backgroundColor: dark ? const Color(0xFF2A2A2A) : const Color(0xFFF7F5F3),
      selectedColor: AppColors.primary.withValues(alpha: 0.14),
      labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
    ),
    dividerTheme: DividerThemeData(
      color: dark ? const Color(0xFF2E2E2E) : AppColors.divider,
      thickness: 1,
      space: 0,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surface,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: dark ? const Color(0xFF8C8C8E) : AppColors.textSecondary,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
    ),
  );
}
