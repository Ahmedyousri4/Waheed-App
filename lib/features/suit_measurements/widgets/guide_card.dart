import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Guide card showing measurement instructions with step-specific icon.
class GuideCard extends StatelessWidget {
  final int currentStep;

  const GuideCard({super.key, required this.currentStep});

  String get _guideIcon => currentStep == 2 ? "trousers.svg" : "suit.svg";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: AppImage(image: _guideIcon, height: 48, width: 48),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    AppImage(
                      image: "size.svg",
                      height: 16,
                      width: 16,
                      color: AppColors.gold,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "دليل القياس",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "قِس بدقة فوق ملابسك العادية وأبقِ شريط القياس مستوياً وغير مشدود",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Inter",
                    color: AppColors.textSlate,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
