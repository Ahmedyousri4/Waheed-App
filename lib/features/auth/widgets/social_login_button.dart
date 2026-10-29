import 'package:flutter/material.dart';
import 'package:waheed/core/widgets/app_image.dart';
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
    this.height = 50,
    this.borderRadius = 14,
    this.borderColor,
    this.labelStyle,
    this.gap = 8,
    this.iconTrailing = false,
  });

  final String label;
  final String iconPath;
  final double? iconWidth;
  final double? iconHeight;
  final VoidCallback? onTap;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final TextStyle? labelStyle;
  final double gap;
  final bool iconTrailing;

  @override
  Widget build(BuildContext context) {
    final iconName =
        iconPath.startsWith('assets/icons/')
            ? iconPath.substring('assets/icons/'.length)
            : (iconPath.startsWith('assets/images/')
                ? iconPath.substring('assets/images/'.length)
                : iconPath);
    final iconWidget = AppImage(
      image: iconName,
      width: iconWidth,
      height: iconHeight,
    );
    final textWidget = Text(
      label,
      style: labelStyle ?? AuthStyles.socialButton,
    );

    return Expanded(
      child: Material(
        color: AuthStyles.white,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor ?? AuthStyles.border),
            ),
            child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!iconTrailing) ...[
                  iconWidget,
                  SizedBox(width: gap),
                  textWidget,
                ] else ...[
                  textWidget,
                  SizedBox(width: gap),
                  iconWidget,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
