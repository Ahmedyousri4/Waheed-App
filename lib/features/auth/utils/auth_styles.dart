import 'package:flutter/material.dart';

/// Scoped design tokens and typography for Screen 01 (Get Started)
/// and Screen 02 (Login) (Figma nodes 549:8382 & 549:8392).
///
/// Implements user-confirmed styles using the Cairo fallback font family
/// (IBM Plex Sans Arabic is not currently bundled/registered).
abstract final class AuthStyles {
  // ── Font Family ───────────────────────────────────────────────────
  /// Fallback font family registered in pubspec.yaml.
  static const String fontFamily = 'Cairo';

  // ── Colors ────────────────────────────────────────────────────────
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDescription = Color(0xFF939393);
  static const Color textHint = Color(0xFFBFC6D0);
  static const Color textSlate = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF8F8F8F);
  static const Color border = Color(0xFFECECEC);
  static const Color divider = Color(0xFFE2E8F0);
  static const Color photoOverlay = Color(0x59000000); // 35% black overlay

  // ── User-Confirmed Shared Typography ──────────────────────────────

  /// Title style: 600 SemiBold, 24px, 100% line height, black, centered.
  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0,
    color: black,
  );

  /// Subtitle style: 400 Regular, 14px, 22.75px line height, black, centered.
  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 22.75 / 14,
    letterSpacing: 0,
    color: black,
  );

  /// Description style: 400 Regular, 14px, 100% line height, #939393, right-aligned.
  static const TextStyle description = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.0,
    letterSpacing: 0,
    color: textDescription,
  );

  // ── Screen-Specific Typography ────────────────────────────────────

  /// Primary CTA label: 16px, 600 SemiBold, white, centered.
  static const TextStyle ctaButton = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: white,
  );

  /// Input field label: 14px, 500 Medium, black, right-aligned.
  static const TextStyle fieldLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: black,
  );

  /// Input field hint text: 14px, 400 Regular, #BFC6D0.
  static const TextStyle fieldHint = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: textHint,
  );

  /// Input field typed value: 14px, 400 Regular, black.
  static const TextStyle fieldValue = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: black,
  );

  /// Forgot password link text: 13px, 400 Regular, slate gray.
  static const TextStyle forgotPassword = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: textSlate,
  );

  /// Social divider caption: 13px, 400 Regular, muted gray.
  static const TextStyle dividerText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: textMuted,
  );

  /// Social button label: 14px, 500 Medium, black.
  static const TextStyle socialButton = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: black,
  );
}
