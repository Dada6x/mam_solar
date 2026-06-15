import 'package:flutter/material.dart';

/// Central color palette.
///
/// Redesign note: the app now follows a smapOne-style **blue/white** look.
/// The canonical brand color is [primaryBlue]. The old green/yellow names
/// (`primaryGreen`, `accentYellow`, `sectionBg`) are kept as **legacy aliases**
/// that now point at the blue palette, so existing widgets keep working without
/// edits. Prefer the blue names below in new code.
class AppColors {
  AppColors._();

  // === smapOne-style brand palette (blue) ===
  /// Primary accent, used for buttons, active controls, links, required `*`.
  static const Color primaryBlue = Color(0xFF2196F3);

  /// Darker blue for pressed states / strong accents.
  static const Color primaryBlueDark = Color(0xFF1976D2);

  /// Light blue tint for pills, selected backgrounds, highlights.
  static const Color primaryBlueLight = Color(0xFFE3F0FC);

  /// Blue asterisk shown next to required-field labels.
  static const Color requiredBlue = Color(0xFF2196F3);

  // === Neutrals ===
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color errorRed = Color(0xFFD32F2F);
  static const Color amber = Color(0xFFFFA000);
  static const Color grey = Color(0xFF9E9E9E);

  /// Scaffold / page background (light grey, cards sit on top of this).
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF555555);
  static const Color labelGrey = Color(0xFF555555);

  /// Near-black slate for headings and app-bar title (smapOne text tone).
  static const Color textDark = Color(0xFF1F2933);

  /// Subtle border for inputs, cards and dividers.
  static const Color borderGrey = Color(0xFFD9DDE3);

  /// Border tone for the dashed photo/signature upload boxes.
  static const Color dashedBorderGrey = Color(0xFFBFC6D1);

  /// Background of a section card.
  static const Color cardWhite = Colors.white;

  // === Legacy aliases (now mapped onto the blue palette) ===
  // Kept so existing widgets compile unchanged; migrate to the names above.
  static const Color primaryGreen = primaryBlue;
  static const Color accentYellow = primaryBlue;
  static const Color sectionBg = primaryBlue;
}
