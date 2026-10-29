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
    this.focusNode,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.textDirection,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    this.height = 50,
    this.borderRadius = 14,
    this.borderColor,
    this.horizontalPadding = 14,
    this.verticalPadding = 14,
    this.labelStyle,
    this.hintStyle,
    this.errorText,
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextDirection? textDirection;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final double horizontalPadding;
  final double verticalPadding;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor =
        errorText != null
            ? AuthStyles.error
            : (borderColor ?? AuthStyles.border);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: labelStyle ?? AuthStyles.fieldLabel,
        ),
        const SizedBox(height: 8),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: AuthStyles.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: effectiveBorderColor),
          ),
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              if (prefixIcon != null) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: prefixIcon,
                ),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  textInputAction: textInputAction,
                  textDirection: textDirection ?? TextDirection.rtl,
                  style: AuthStyles.fieldValue,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: hintStyle ?? AuthStyles.fieldHint,
                    hintTextDirection: textDirection,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: suffixIcon,
                ),
              ],
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            textAlign: TextAlign.right,
            style: AuthStyles.fieldError,
          ),
        ],
      ],
    );
  }
}
