import 'package:flutter/material.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/app/theme/app_colors.dart';

/// Standard circular back button used across all screens.
///
/// Wraps an ink-well with the app's standard bordered-circle styling.
class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AppBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderLight, width: 1.5),
        ),
        child: const Center(
          child: AppImage(image: "arrowleft.svg", height: 16, width: 16),
        ),
      ),
    );
  }
}
