import 'package:flutter/material.dart';

/// Centralized color palette for the Waheed app.
///
/// All hardcoded hex colors are gathered here so future theming
/// changes require editing a single file.
abstract final class AppColors {
  // ── Brand ─────────────────────────────────────────────────────────
  static const Color gold = Color(0xFFC9A961);
  static const Color goldDark = Color(0xFF473100);
  static const Color navy = Color(0xFF314158);

  // ── Neutral ───────────────────────────────────────────────────────
  static const Color black = Color(0xFF111111);
  static const Color white = Colors.white;
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFECECEC);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color divider = Color(0xFFE2E8F0);

  // ── Text ──────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF8F8F8F);
  static const Color textMuted = Color(0xFFA0A0A0);
  static const Color textSlate = Color(0xFF94A3B8);
  static const Color textSlateSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFFBFC6D0);

  // ── Surface ───────────────────────────────────────────────────────
  static const Color surfaceLight = Color(0xFFF1F5F9);
  static const Color surfaceSubtle = Color(0xFFF8FAFC);
  static const Color surfaceMeasurements = Color(0xFFF7F8FA);

  // ── Semantic ──────────────────────────────────────────────────────
  static const Color warning = Color(0xFFFFFBEB);
  static const Color warningText = Color(0xFF7B3306);
  static const Color star = Color(0xFFFFC107);
  static const Color error = Colors.red;

  // ── Inactive ──────────────────────────────────────────────────────
  static const Color inactive = Color(0xFFE2E8F0);
  static const Color pageIndicator = Color(0xFFD9D9D9);
}
