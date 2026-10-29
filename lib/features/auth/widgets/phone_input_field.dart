import 'package:flutter/material.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';

/// Form input field for phone number entry matching Screen 03 (Figma node 549:8455).
///
/// Features a +20 country prefix and vertical divider at the physical left,
/// LTR phone digits input, and a 20×20 call mark (assets/icons/call.svg)
/// at the physical right edge.
class PhoneInputField extends StatelessWidget {
  const PhoneInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor =
        errorText != null ? AuthStyles.error : AuthStyles.fieldBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          textAlign: TextAlign.right,
          style: AuthStyles.signUpFieldLabel,
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: AuthStyles.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: effectiveBorderColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            textDirection: TextDirection.ltr,
            children: [
              // Country code prefix and divider group
              const Text(
                '+20',
                textDirection: TextDirection.ltr,
                style: AuthStyles.signUpFieldLabel,
              ),
              const SizedBox(width: 8),
              Container(width: 1, height: 26, color: AuthStyles.fieldBorder),
              const SizedBox(width: 8),
              // Phone digits input
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: TextInputType.phone,
                  textInputAction: textInputAction,
                  textDirection: TextDirection.ltr,
                  style: AuthStyles.fieldValue,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: AuthStyles.signUpFieldHint,
                    hintTextDirection: TextDirection.ltr,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Call icon at physical right
              const AppImage(image: 'call.svg', width: 20, height: 20),
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
