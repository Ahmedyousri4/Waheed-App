import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';

/// Full-width black CTA button used in bottom sheets.
///
/// Height ≈ 56, radius ≈ 16, white label. Pass `null` to [onPressed]
/// to render a disabled state.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          disabledBackgroundColor: AppColors.black.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
