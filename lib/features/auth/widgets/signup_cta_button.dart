import 'package:flutter/material.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';

/// Primary action button for Screen 03 (Sign Up).
///
/// Implements the 370×56 black container with radius 16,
/// 8px blur shadow, and "إنشاء حساب" white label.
class SignUpCtaButton extends StatelessWidget {
  const SignUpCtaButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  static const String label = 'إنشاء حساب';

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      key: const Key('signup_button'),
      color: AuthStyles.black,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1E000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child:
              isLoading
                  ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AuthStyles.white,
                      ),
                    ),
                  )
                  : const Text(label, style: AuthStyles.signUpCtaButton),
        ),
      ),
    );
  }
}
