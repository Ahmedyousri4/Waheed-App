import 'package:flutter/material.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';
import 'package:waheed/features/auth/widgets/auth_text_field.dart';

/// Password and confirm-password field group for Screen 03 (Sign Up).
///
/// Implements independent visibility toggles swapping eyeoff.svg and eye.svg
/// positioned at the physical left edge with Arabic RTL text input.
class SignUpPasswordFields extends StatelessWidget {
  const SignUpPasswordFields({
    super.key,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.confirmPasswordController,
    required this.confirmPasswordFocusNode,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    this.passwordError,
    this.confirmPasswordError,
    this.onSubmitted,
  });

  static const String passwordLabel = 'كلمة المرور';
  static const String passwordHint = '••••••••';
  static const String confirmPasswordLabel = 'تأكيد كلمة المرور';
  static const String confirmPasswordHint = '••••••••';

  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final TextEditingController confirmPasswordController;
  final FocusNode confirmPasswordFocusNode;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final String? passwordError;
  final String? confirmPasswordError;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTextField(
          label: passwordLabel,
          hintText: passwordHint,
          controller: passwordController,
          focusNode: passwordFocusNode,
          obscureText: obscurePassword,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          textDirection: TextDirection.rtl,
          height: 48,
          borderRadius: 12,
          borderColor: AuthStyles.fieldBorder,
          horizontalPadding: 16,
          verticalPadding: 8,
          labelStyle: AuthStyles.signUpFieldLabel,
          hintStyle: AuthStyles.signUpFieldHint,
          errorText: passwordError,
          prefixIcon: GestureDetector(
            key: const Key('signup_password_toggle'),
            onTap: onTogglePassword,
            behavior: HitTestBehavior.opaque,
            child: AppImage(
              image: obscurePassword ? 'eyeoff.svg' : 'eye.svg',
              width: 20,
              height: 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        AuthTextField(
          label: confirmPasswordLabel,
          hintText: confirmPasswordHint,
          controller: confirmPasswordController,
          focusNode: confirmPasswordFocusNode,
          obscureText: obscureConfirmPassword,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          textDirection: TextDirection.rtl,
          height: 48,
          borderRadius: 12,
          borderColor: AuthStyles.fieldBorder,
          horizontalPadding: 16,
          verticalPadding: 8,
          labelStyle: AuthStyles.signUpFieldLabel,
          hintStyle: AuthStyles.signUpFieldHint,
          errorText: confirmPasswordError,
          onSubmitted: onSubmitted,
          prefixIcon: GestureDetector(
            key: const Key('signup_confirm_password_toggle'),
            onTap: onToggleConfirmPassword,
            behavior: HitTestBehavior.opaque,
            child: AppImage(
              image: obscureConfirmPassword ? 'eyeoff.svg' : 'eye.svg',
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }
}
