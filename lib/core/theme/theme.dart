import 'package:flutter/material.dart';

import './colors.dart';
import './sizes.dart';


class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.background,
      error: AppColors.error,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16.0, color: AppColors.textPrimary),
      bodyMedium: TextStyle(fontSize: 14.0, color: AppColors.textSecondary),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.accent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.textPrimary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16.0, color: AppColors.background),
      bodyMedium: TextStyle(fontSize: 14.0, color: AppColors.textSecondary),
    ),
  );
}
