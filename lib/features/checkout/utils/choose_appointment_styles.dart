import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/app/theme/app_text_styles.dart';

/// Styles and tokens scoped to Figma node 3526:5940.
///
/// Figma specifies IBM Plex Sans Arabic, which is not bundled. Cairo is the
/// project's documented Arabic body font, so local styles derive from the
/// closest shared [AppTextStyles] and apply Cairo plus only the Figma-specific
/// metrics/colors. This keeps the approved exception within checkout.
abstract final class ChooseAppointmentStyles {
  static const String _arabicFont = 'Cairo';

  // Figma colors with no exact AppColors token. These stay local to this node.
  static const Color hairline = Color(0xFFEAEAEA);
  static const Color mutedBlueGray = Color(0xFF62748E);
  static const Color nearBlack = Color(0xFF0A0A0A);
  static const Color dateAndSlotText = Color(0xFF0F172A);
  static const Color unavailableText = Color(0xFFCBD5E1);
  static const Color branchIconTile = Color(0x0F1E3A8A);
  static const Color activeCtaFill = Color(0xFF000000);
  static const Color shadow = Color(0x1A000000);
  static const Color backButtonShadowColor = Color(0x0F000000);

  // Figma-specific text metrics composed from the closest shared styles.
  static final TextStyle headerTitle = AppTextStyles.titleLarge.copyWith(
    fontFamily: _arabicFont,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  // Shared bodyLarge already matches Figma's 15 px / w600; Cairo and line
  // height are the scoped typography differences.
  static final TextStyle sectionHeading = AppTextStyles.bodyLarge.copyWith(
    fontFamily: _arabicFont,
    height: 22.5 / 15,
    color: AppColors.navy,
  );

  // Shared bodySmall matches the 12 px regular size; Cairo, line height, and
  // Figma muted color are screen-specific.
  static final TextStyle monthLabel = AppTextStyles.bodySmall.copyWith(
    fontFamily: _arabicFont,
    height: 16 / 12,
    color: mutedBlueGray,
  );

  // Figma's compact date labels do not have direct AppTextStyles equivalents.
  static final TextStyle dateWeekday = AppTextStyles.labelSmall.copyWith(
    fontFamily: _arabicFont,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 15 / 10,
  );

  static final TextStyle dateNumber = AppTextStyles.label.copyWith(
    fontFamily: _arabicFont,
    fontSize: 18,
    height: 28 / 18,
  );

  static final TextStyle dateMonth = AppTextStyles.labelSmall.copyWith(
    fontFamily: _arabicFont,
    fontSize: 9,
    fontWeight: FontWeight.w500,
    height: 13.5 / 9,
  );

  static final TextStyle timeSlot = AppTextStyles.titleSmall.copyWith(
    fontFamily: _arabicFont,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
  );

  static final TextStyle branchTitle = AppTextStyles.label.copyWith(
    fontFamily: _arabicFont,
    fontWeight: FontWeight.w600,
    color: nearBlack,
  );

  static final TextStyle branchSubtitle = AppTextStyles.labelSmall.copyWith(
    fontFamily: _arabicFont,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 16 / 10,
    color: mutedBlueGray,
  );

  static final TextStyle ctaLabel = AppTextStyles.titleMedium.copyWith(
    fontFamily: _arabicFont,
    fontWeight: FontWeight.w600,
  );

  // The Figma node has only the active CTA. Product requirements define a
  // disabled-looking initial state; use the closest existing project tokens.
  static const Color disabledCtaFill = AppColors.divider;
  static const Color disabledCtaLabel = AppColors.textSlateSecondary;

  static const List<BoxShadow> panelShadow = [
    BoxShadow(offset: Offset(0, 1), blurRadius: 1.5, color: shadow),
    BoxShadow(offset: Offset(0, 1), blurRadius: 1, color: shadow),
  ];

  static const List<BoxShadow> ctaShadow = [
    BoxShadow(offset: Offset(0, 10), blurRadius: 7.5, color: shadow),
    BoxShadow(offset: Offset(0, 4), blurRadius: 3, color: shadow),
  ];

  static const List<BoxShadow> backButtonShadow = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 1,
      color: backButtonShadowColor,
    ),
  ];
}
