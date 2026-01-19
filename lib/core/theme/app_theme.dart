import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colores principales basados en el diseño PDF (azul oscuro)
  static const Color primaryColor = Color(0xFF1B2B5E);
  static const Color primaryLightColor = Color.fromRGBO(1, 1, 48, 1);
  static const Color primaryDarkColor = Color(0xFF0A1538);

  static const Color secondaryColor = Color(0xFF00BCD4);
  static const Color accentColor = Color(0xFF4FC3F7);

  static const Color backgroundColor = Color.fromRGBO(1, 1, 48, 1);
  static const Color surfaceColor = Color(0xFF253A7D);
  static const Color cardColor = Color(0xFF2E4BA5);

  static const Color textPrimaryColor = Colors.white;
  static const Color textSecondaryColor = Color(0xFFB0BEC5);
  static const Color textHintColor = Color(0xFF78909C);

  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color errorColor = Color(0xFFF44336);

  static const Color dividerColor = Color(0xFF37474F);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      primarySwatch: Colors.blue,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: textPrimaryColor,
        onSecondary: textPrimaryColor,
        onSurface: textPrimaryColor,
        onError: textPrimaryColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      dividerColor: dividerColor,
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.dark().textTheme.apply(
              bodyColor: textPrimaryColor,
              displayColor: textPrimaryColor,
            ),
      ).copyWith(
        headlineLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimaryColor,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimaryColor,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimaryColor,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          color: textPrimaryColor,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          color: textSecondaryColor,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12,
          color: textHintColor,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: textPrimaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryLightColor,
          foregroundColor: textPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimaryColor,
          side: const BorderSide(color: primaryLightColor),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryLightColor, width: 2),
        ),
        hintStyle: GoogleFonts.poppins(color: textHintColor),
        labelStyle: GoogleFonts.poppins(color: textSecondaryColor),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
