import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 2, color: color),
      );

  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.darkBlue,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.gold,
          surface: AppColors.darkBlue,
          error: AppColors.red,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
          bodySmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: AppColors.gold,
          ),
        ),
        // Elevated Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(AppColors.gold),
            foregroundColor: const WidgetStatePropertyAll(AppColors.darkBlue),
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            elevation: const WidgetStatePropertyAll(0),
            padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
        // Text Form Field
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkBlue,
          contentPadding: const EdgeInsets.all(16),
          hintStyle: const TextStyle(
            color: AppColors.lightBlue,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          errorStyle: const TextStyle(color: AppColors.red),
          border: _border(AppColors.gold),
          enabledBorder: _border(AppColors.gold),
          focusedBorder: _border(AppColors.gold),
          errorBorder: _border(AppColors.red),
          focusedErrorBorder: _border(AppColors.red),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.gold,
          selectionHandleColor: AppColors.gold,
          selectionColor: AppColors.gold.withValues(alpha: 0.4),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.darkBlue,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
        ),
      );
}
