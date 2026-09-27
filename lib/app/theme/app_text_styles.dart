import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Reusable text styles used throughout the Waheed app.
///
/// Covers the most common text configurations. Screens may still
/// compose one-off styles, but these should cover the 80% case.
abstract final class AppTextStyles {
  static const String _fontFamily = 'Inter';

  // ── Headings ──────────────────────────────────────────────────────
  static const TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
    color: AppColors.textPrimary,
  );

  // ── Body ──────────────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 13,
    fontFamily: _fontFamily,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontFamily: _fontFamily,
    color: AppColors.textSlate,
  );

  // ── Labels ────────────────────────────────────────────────────────
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: _fontFamily,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontFamily: _fontFamily,
    color: AppColors.textSlate,
  );

  // ── Step / progress ───────────────────────────────────────────────
  static const TextStyle stepLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: _fontFamily,
    color: AppColors.gold,
  );

  // ── Brand ─────────────────────────────────────────────────────────
  static const TextStyle brand = TextStyle(
    fontSize: 13,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w900,
    color: Colors.black,
  );

  // ── Navigation ────────────────────────────────────────────────────
  static const TextStyle navLabel = TextStyle(
    fontSize: 11,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
  );

  static const TextStyle navLabelActive = TextStyle(
    fontSize: 11,
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}
