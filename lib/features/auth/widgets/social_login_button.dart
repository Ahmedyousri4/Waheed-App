import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';

/// Reusable social sign-in button with vector SVG icon and provider label.
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.label,
    required this.iconPath,
    this.iconWidth,
    this.iconHeight,
    this.onTap,
  });

  final String label;
  final String iconPath;
  final double? iconWidth;
  final double? iconHeight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: AuthStyles.white,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AuthStyles.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: iconWidth,
                  height: iconHeight,
                ),
                const SizedBox(width: 8),
                Text(label, style: AuthStyles.socialButton),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
