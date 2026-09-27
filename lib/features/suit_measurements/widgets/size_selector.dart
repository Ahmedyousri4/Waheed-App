import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';

/// Size selector chip row (e.g. S/M/L/XL/XXL or 28/30/32/34/36).
///
/// Reused for both the measurement steps and the review step.
class SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final String? title;
  final bool showBadge;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selectedIndex,
    required this.onSelected,
    this.title,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? "اختر مقاساً جاهزاً",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                  color: AppColors.textPrimary,
                ),
              ),
              if (showBadge)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "سريع",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                      color: AppColors.gold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: List.generate(sizes.length, (index) {
              final isSelected = selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onSelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    margin: EdgeInsets.only(
                      left: index < sizes.length - 1 ? 8 : 0,
                    ),
                    height: 44,
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppColors.navy : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? AppColors.navy : AppColors.divider,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        sizes[index],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Inter",
                          color:
                              isSelected
                                  ? Colors.white
                                  : AppColors.textSlateSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
