import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Header displaying current step number, title, and subtitle.
class StepHeader extends StatelessWidget {
  final int currentStep;

  static const List<String> _stepLabels = [
    'الجاكيت',
    'القميص',
    'البنطلون',
    'المراجعة',
  ];
  static const List<String> _stepSubtitles = [
    'قياسات الجاكيت العلوية',
    'قياسات الرقبة والأكمام',
    'قياسات الخصر والساق',
    'تأكيد القياسات',
  ];
  static const List<String> _stepNumbers = ['١', '٢', '٣', '٤'];

  const StepHeader({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const AppImage(image: "similar.svg", width: 12, height: 12),
            Text(
              " الخطوة ${_stepNumbers[currentStep]} من ٤",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter",
                color: AppColors.gold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          _stepLabels[currentStep],
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _stepSubtitles[currentStep],
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
            color: AppColors.textSlate,
          ),
        ),
      ],
    );
  }
}
