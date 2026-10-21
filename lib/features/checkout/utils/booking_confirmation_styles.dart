import 'package:flutter/material.dart';

/// Scoped colors and typography for Booking Confirmation (Figma node 3526:6123).
///
/// Keeps screen-specific design tokens isolated within the checkout feature,
/// avoiding pollution of the global AppColors and AppTextStyles palettes.
abstract final class BookingConfirmationStyles {
  // ── Colors ─────────────────────────────────────────────────────────

  static const Color bgScreen = Color(0xFFFAFAFA);
  static const Color headerGradientStart = Color(0xFF314158);
  static const Color headerGradientEnd = Color(0xFF0A0A0A);
  static const Color goldAccent = Color(0xFFC9A961);
  static const Color navyText = Color(0xFF314158);
  static const Color slateText = Color(0xFF62748E);
  static const Color subtleCardBg = Color(0xFFF8FAFC);
  static const Color cardBorder = Color(0xFFF1F5F9);
  static const Color tileNavyBg = Color(0x0F1E3A8A); // rgba(30,58,138,0.06)
  static const Color tileGoldBg = Color(0x21C9A961); // rgba(201,169,97,0.13)
  static const Color nearBlack = Color(0xFF0A0A0A);

  // ── Typography ─────────────────────────────────────────────────────

  static const String fontFamily = 'Cairo';

  static const TextStyle headerTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    height: 33 / 22,
    color: Colors.white,
  );

  static const TextStyle headerSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 20 / 14,
    color: Color(0xCCFFFFFF), // rgba(255,255,255,0.8)
  );

  static const TextStyle orderLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.normal,
    height: 16.5 / 11,
    color: navyText,
  );

  static const TextStyle orderNumber = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
    height: 24 / 16,
    color: Colors.black,
  );

  static const TextStyle copyText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    color: Colors.black,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 16 / 12,
    color: navyText,
  );

  static const TextStyle detailLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 16.5 / 12,
    color: slateText,
  );

  static const TextStyle detailTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
    color: nearBlack,
  );

  static const TextStyle detailSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.normal,
    height: 16 / 11,
    color: slateText,
  );

  static const TextStyle tailoringSubline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 16.5 / 11,
    color: goldAccent,
  );

  static TextStyle buttonText({required Color color}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 22 / 14,
    color: color,
  );
}
