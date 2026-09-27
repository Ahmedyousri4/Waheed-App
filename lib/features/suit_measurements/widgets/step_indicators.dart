import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Horizontal step indicator bar showing progress through the 4 steps.
///
/// Supports tapping on completed steps to navigate backwards.
class StepIndicators extends StatelessWidget {
  final int currentStep;
  final ValueChanged<int> onStepTap;

  static const List<String> _stepLabels = [
    'الجاكيت',
    'القميص',
    'البنطلون',
    'المراجعة',
  ];
  static const List<String> _stepNumbers = ['١', '٢', '٣', '٤'];

  const StepIndicators({
    super.key,
    required this.currentStep,
    required this.onStepTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(7, (i) {
            if (i.isEven) {
              return _buildStepCircle(i ~/ 2);
            } else {
              return _buildDividerLine(i ~/ 2);
            }
          }),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            final isActive = index == currentStep;
            return SizedBox(
              width: 50,
              child: Text(
                _stepLabels[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontFamily: "Inter",
                  color: isActive ? AppColors.navy : AppColors.textSlate,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildStepCircle(int stepIndex) {
    final isActive = stepIndex == currentStep;
    final isPast = stepIndex < currentStep;

    return GestureDetector(
      onTap: () {
        if (stepIndex <= currentStep) onStepTap(stepIndex);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color:
              isActive
                  ? AppColors.navy
                  : isPast
                  ? AppColors.gold
                  : AppColors.inactive,
          shape: BoxShape.circle,
          boxShadow:
              isActive
                  ? [
                    BoxShadow(
                      color: AppColors.navy.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                  : isPast
                  ? [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                  : null,
        ),
        child: Center(
          child:
              isPast
                  ? const AppImage(
                    image: "done.svg",
                    height: 20,
                    width: 20,
                    color: Colors.white,
                  )
                  : Text(
                    _stepNumbers[stepIndex],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                      color: isActive ? Colors.white : AppColors.textSlate,
                    ),
                  ),
        ),
      ),
    );
  }

  Widget _buildDividerLine(int leftStepIndex) {
    final isPast = leftStepIndex < currentStep;
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isPast ? AppColors.gold : AppColors.inactive,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}
