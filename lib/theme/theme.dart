import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF3B5BA9);
  static const secondary = Color(0xFF9DB6E3);
  static const accent = Color(0xFF1C2D5A);
  static const background = Color(0xFFF5F6FA);
  static const textPrimary = Color(0xFF1E1E2D);
  static const textSecondary = Color(0xFF5A5A89);
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.primary,
  cardColor: Colors.white,
  textTheme: GoogleFonts.nunitoTextTheme().copyWith(
    titleMedium: const TextStyle(
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: const TextStyle(
      color: Colors.black87,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
  textStyle: GoogleFonts.nunito(
    fontSize: 14,
    color: Colors.black,
  ),
),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.transparent,
  primaryColor: AppColors.primary,
  cardColor: const Color(0xFF2F3A4C),
  textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme).copyWith(
    titleMedium: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: const TextStyle(
      color: Colors.white,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
  textStyle: GoogleFonts.nunito(
    fontSize: 14,
    color: Colors.white,
  ),
),
);
