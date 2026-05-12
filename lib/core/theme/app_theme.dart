import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.danger,
        surface: AppColors.card,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.text,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1,
        displayMedium: AppTextStyles.h2,
        displaySmall: AppTextStyles.h3,
        headlineMedium: AppTextStyles.h4,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ).apply(
        bodyColor: AppColors.text,
        displayColor: AppColors.text,
        fontFamily: AppTextStyles.nunito.fontFamily,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.card,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.text),
        titleTextStyle: AppTextStyles.h3.copyWith(color: AppColors.text),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppTextStyles.labelLarge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.muted),
        labelStyle: AppTextStyles.labelMedium.copyWith(color: AppColors.text),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.danger,
        surface: AppColors.darkCard,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkText,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1.copyWith(color: AppColors.darkText),
        displayMedium: AppTextStyles.h2.copyWith(color: AppColors.darkText),
        displaySmall: AppTextStyles.h3.copyWith(color: AppColors.darkText),
        headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.darkText),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.darkText),
        bodyMedium:
            AppTextStyles.bodyMedium.copyWith(color: AppColors.darkText),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.darkMuted),
        labelLarge:
            AppTextStyles.labelLarge.copyWith(color: AppColors.darkText),
        labelMedium:
            AppTextStyles.labelMedium.copyWith(color: AppColors.darkText),
        labelSmall:
            AppTextStyles.labelSmall.copyWith(color: AppColors.darkMuted),
      ).apply(
        bodyColor: AppColors.darkText,
        displayColor: AppColors.darkText,
        fontFamily: AppTextStyles.nunito.fontFamily,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkCard,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.darkText),
        titleTextStyle: AppTextStyles.h3.copyWith(color: AppColors.darkText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppTextStyles.labelLarge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard,
        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkMuted),
        labelStyle: AppTextStyles.labelMedium.copyWith(color: AppColors.darkText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
      ),
    );
  }
}
