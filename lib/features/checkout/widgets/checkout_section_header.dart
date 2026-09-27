import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Section header used consistently across all checkout sections.
///
/// Displays an icon + title row aligned for RTL.
class CheckoutSectionHeader extends StatelessWidget {
  final String icon;
  final String title;

  const CheckoutSectionHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(image: icon, height: 20, width: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            fontFamily: 'Inter',
            color: AppColors.navy,
          ),
        ),
      ],
    );
  }
}
