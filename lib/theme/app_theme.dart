import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Red palette
  static const Color redDark = Color(0xFFB71C1C);
  static const Color red = Color(0xFFD32F2F);
  static const Color redLight = Color(0xFFEF5350);
  static const Color redPale = Color(0xFFFFEBEE);

  // Blue palette
  static const Color blueDark = Color(0xFF0D47A1);
  static const Color blue = Color(0xFF1565C0);
  static const Color blueLight = Color(0xFF1976D2);
  static const Color bluePale = Color(0xFFE3F2FD);

  // Neutral
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8F9FA);
  static const Color gray100 = Color(0xFFF1F3F4);
  static const Color gray200 = Color(0xFFE8EAED);
  static const Color gray300 = Color(0xFFDADCE0);
  static const Color gray500 = Color(0xFF9AA0A6);
  static const Color gray700 = Color(0xFF5F6368);
  static const Color gray900 = Color(0xFF202124);

  // Semantic
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color gold = Color(0xFFFDD835);
  static const Color orange = Color(0xFFFF6D00);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.red,
        primary: AppColors.red,
        secondary: AppColors.blue,
        surface: AppColors.white,
        background: AppColors.offWhite,
      ),
      textTheme: GoogleFonts.barlowTextTheme().copyWith(
        displayLarge: GoogleFonts.oswald(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.gray900,
        ),
        displayMedium: GoogleFonts.oswald(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
        ),
        titleLarge: GoogleFonts.oswald(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.gray900,
          letterSpacing: 0.5,
        ),
        titleMedium: GoogleFonts.oswald(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.gray900,
        ),
        bodyLarge: GoogleFonts.barlow(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.gray900,
        ),
        bodyMedium: GoogleFonts.barlow(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.gray700,
        ),
        bodySmall: GoogleFonts.barlow(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.gray500,
        ),
      ),
      scaffoldBackgroundColor: AppColors.offWhite,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.redDark,
        foregroundColor: AppColors.white,
        elevation: 0,
        titleTextStyle: GoogleFonts.oswald(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
