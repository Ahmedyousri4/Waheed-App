import 'package:flutter/material.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';

/// Bottom system indicator area for Screen 03 (Figma node 549:8455).
///
/// Documents the 402×33 white container and 139×5 black indicator bar.
/// Note: The supplied Flutter export positioned this at left=270, top=25
/// with 3.14 rad rotation, whereas prior Figma design-context described a
/// centered bar with 8px bottom inset.
class SignUpSystemBar extends StatelessWidget {
  const SignUpSystemBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      color: AuthStyles.white,
      alignment: Alignment.center,
      child: Container(
        width: 139,
        height: 5,
        decoration: BoxDecoration(
          color: AuthStyles.black,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
