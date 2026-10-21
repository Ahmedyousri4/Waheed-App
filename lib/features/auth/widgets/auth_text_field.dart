import 'package:flutter/material.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';

/// Reusable input field for authentication forms with optional prefix/suffix icons,
/// custom text alignment, and secure entry toggle.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.textDirection,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, textAlign: TextAlign.right, style: AuthStyles.fieldLabel),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AuthStyles.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AuthStyles.border),
          ),
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              if (prefixIcon != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: prefixIcon,
                ),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  textDirection: textDirection ?? TextDirection.rtl,
                  style: AuthStyles.fieldValue,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: AuthStyles.fieldHint,
                    hintTextDirection: textDirection,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: suffixIcon,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
