import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/utils/choose_appointment_styles.dart';

/// The 48 px back control used only by Figma node 3526:5940.
///
/// The shared [AppBackButton] is 44 px with a 16 px icon; the target specifies
/// 48 px and a 24 px icon. This local control preserves the shared arrow asset
/// and colors without changing the global component.
class ChooseAppointmentBackButton extends StatelessWidget {
  const ChooseAppointmentBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'رجوع',
      child: InkWell(
        onTap: () => Navigator.of(context).maybePop(),
        borderRadius: BorderRadius.circular(99),
        child: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border, width: 1),
            boxShadow: ChooseAppointmentStyles.backButtonShadow,
          ),
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: math.pi,
            child: const AppImage(
              image: 'arrowleft.svg',
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
    );
  }
}
