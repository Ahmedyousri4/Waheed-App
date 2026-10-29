import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';

/// Centered heading block for Screen 03 (Sign Up).
///
/// Displays the title "إنشاء حساب" and the account prompt
/// with a tappable "تسجيل الدخول" link.
class SignUpHeader extends StatefulWidget {
  const SignUpHeader({super.key, required this.onLoginTap});

  static const String titleText = 'إنشاء حساب';
  static const String accountPromptPrefix = 'لديك حساب بالفعل؟ ';
  static const String loginLinkText = 'تسجيل الدخول';

  final VoidCallback onLoginTap;

  @override
  State<SignUpHeader> createState() => _SignUpHeaderState();
}

class _SignUpHeaderState extends State<SignUpHeader> {
  late final TapGestureRecognizer _loginTapRecognizer;

  @override
  void initState() {
    super.initState();
    _loginTapRecognizer = TapGestureRecognizer()..onTap = widget.onLoginTap;
  }

  @override
  void dispose() {
    _loginTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          SignUpHeader.titleText,
          textAlign: TextAlign.center,
          style: AuthStyles.title,
        ),
        const SizedBox(height: 4),
        GestureDetector(
          key: const Key('login_link'),
          onTap: widget.onLoginTap,
          behavior: HitTestBehavior.opaque,
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: SignUpHeader.accountPromptPrefix,
                  style: AuthStyles.subtitle,
                ),
                TextSpan(
                  text: SignUpHeader.loginLinkText,
                  style: AuthStyles.accountPromptLink,
                  recognizer: _loginTapRecognizer,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
