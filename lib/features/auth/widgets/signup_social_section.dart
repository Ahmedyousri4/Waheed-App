import 'package:flutter/material.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';
import 'package:waheed/features/auth/widgets/social_login_button.dart';

/// Social authentication section for Screen 03 (Sign Up).
///
/// Contains the custom divider with caption "أو تـــــــابــع بواسطة"
/// and the two 48px social buttons for Google and Apple with physical
/// label-left / mark-right layout.
class SignUpSocialSection extends StatelessWidget {
  const SignUpSocialSection({super.key, this.onGoogleTap, this.onAppleTap});

  static const String dividerCaption = 'أو تـــــــابــع بواسطة';

  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Divider row with flanked 1px #EAEAEA lines
        SizedBox(
          height: 17,
          child: Row(
            children: const [
              Expanded(
                child: Divider(color: AuthStyles.fieldBorder, thickness: 1),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  dividerCaption,
                  style: AuthStyles.signUpDividerCaption,
                ),
              ),
              Expanded(
                child: Divider(color: AuthStyles.fieldBorder, thickness: 1),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Social buttons: Google & Apple
        Row(
          textDirection: TextDirection.ltr,
          children: [
            SocialLoginButton(
              label: 'Google',
              iconPath: 'googel.svg',
              iconWidth: 17,
              iconHeight: 17,
              height: 48,
              borderRadius: 14,
              borderColor: AuthStyles.fieldBorder,
              labelStyle: AuthStyles.googleButtonLabel,
              gap: 4,
              iconTrailing: true,
              onTap: onGoogleTap ?? () {},
            ),
            const SizedBox(width: 12),
            SocialLoginButton(
              label: 'Apple',
              iconPath: 'appel.svg',
              iconWidth: 14,
              iconHeight: 17,
              height: 48,
              borderRadius: 14,
              borderColor: AuthStyles.fieldBorder,
              labelStyle: AuthStyles.appleButtonLabel,
              gap: 4,
              iconTrailing: true,
              onTap: onAppleTap ?? () {},
            ),
          ],
        ),
      ],
    );
  }
}
