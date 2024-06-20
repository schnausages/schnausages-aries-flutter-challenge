import 'package:flutter/material.dart';

/// Maintains styles for color scheme and text styles
/// ... ideally would provide Theme/Scheme data for app but will do for now
class AppStyles {
  // Colors
  static const Color baseTileColor = Color(0xFFECEFF1);
  static const Color baseTextColor = Color(0xFF263238);
  static const Color ariesGreenMain = Color(0xFF43A047);
  static const Color ariesPurpleMain = Color(0xFF7225FF);
  static const Color ariesRed = Color(0xFFEF5350);
  static const Color ariesGreenAccent = Color(0xFF5CEC63);
  // Text
  static const TextStyle mainHeaderStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: AppStyles.baseTextColor);
  static const TextStyle subHeaderStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: AppStyles.baseTextColor);

  static const TextStyle smallLabelStyle = TextStyle(
      color: AppStyles.baseTextColor,
      fontWeight: FontWeight.w600,
      fontSize: 10);
}
