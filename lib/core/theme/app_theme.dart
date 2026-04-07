
import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFFE8461A);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primary,
    fontFamily: 'Poppins',
  );
}
