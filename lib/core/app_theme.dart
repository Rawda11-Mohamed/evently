import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight,
      surface: AppColors.inputsLight,
      onSurface: AppColors.secTextLight,
      onSurfaceVariant: AppColors.mainTextLight,
      outline: AppColors.strokeLight,
      error: AppColors.red,
    ),

    textTheme: TextTheme(
      titleLarge: AppTextStyles.s24w600.copyWith(color: AppColors.primaryLight),
      titleMedium: AppTextStyles.s20w600.copyWith(
        color: AppColors.mainTextLight,
      ),
      bodyLarge: AppTextStyles.s16w400.copyWith(color: AppColors.inputsLight),
      bodyMedium: AppTextStyles.s14w400.copyWith(color: AppColors.secTextLight),
      bodySmall: AppTextStyles.s12w400.copyWith(color: AppColors.mainTextLight),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      surface: AppColors.inputsDark,
      onSurface: AppColors.mainTextDark,
      onSurfaceVariant: AppColors.mainTextDark,
      outline: AppColors.strokeDark,
      error: AppColors.red,
    ),

    textTheme: TextTheme(
      titleLarge: AppTextStyles.s24w600.copyWith(color: AppColors.mainTextDark),
      titleMedium: AppTextStyles.s20w600.copyWith(
        color: AppColors.mainTextDark,
      ),
      bodyLarge: AppTextStyles.s16w400.copyWith(color: AppColors.mainTextDark),
      bodyMedium: AppTextStyles.s14w400.copyWith(color: AppColors.mainTextDark),
      bodySmall: AppTextStyles.s12w400.copyWith(color: AppColors.mainTextDark),
    ),
  );
}
