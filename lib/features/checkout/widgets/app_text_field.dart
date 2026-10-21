import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waheed/app/theme/app_colors.dart';

/// Styled text field for the new-card sheet.
///
/// Light-gray fill, thin light border, radius 14, gray hint text,
/// red border on validation error.
class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: 'Inter',
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Inter',
          color: AppColors.textHint,
        ),
        prefixIcon: prefixIcon,
        prefixIconConstraints:
            prefixIcon != null
                ? const BoxConstraints(minWidth: 0, minHeight: 0)
                : null,
        filled: true,
        fillColor: AppColors.surfaceSubtle,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.black, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        errorStyle: const TextStyle(
          fontSize: 11,
          fontFamily: 'Inter',
          color: AppColors.error,
        ),
      ),
    );
  }
}
