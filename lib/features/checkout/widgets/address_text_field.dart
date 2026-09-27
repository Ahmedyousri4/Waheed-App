import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Styled text field used across the add-address form.
///
/// Provides consistent label, hint, icon, border, and RTL styling
/// matching the project's existing input patterns.
class AddressTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? iconAsset;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String? errorText;

  const AddressTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.iconAsset,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color:
                  errorText != null ? AppColors.error : AppColors.borderLight,
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            textAlign: TextAlign.right,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Inter',
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                color: AppColors.textHint,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              prefixIcon:
                  iconAsset != null
                      ? Padding(
                        padding: const EdgeInsets.only(right: 8, left: 14),
                        child: AppImage(
                          image: iconAsset!,
                          height: 20,
                          width: 20,
                          color: AppColors.textSlate,
                        ),
                      )
                      : null,
              prefixIconConstraints: const BoxConstraints(
                minHeight: 20,
                minWidth: 20,
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'Inter',
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}
