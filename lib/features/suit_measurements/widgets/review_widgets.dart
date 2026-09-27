import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Summary card shown at the top of the review (step 4).
class ReviewSummaryCard extends StatelessWidget {
  const ReviewSummaryCard({super.key});

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
          const Text(
            "ملخص",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.gold, AppColors.goldDark],
                  ),
                ),
                child: const Center(
                  child: AppImage(
                    image: "star.svg",
                    height: 26,
                    width: 26,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "بدلة مفصلة حسب القياس",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "جميع القياسات بوحدة سم",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Inter",
                      color: AppColors.textSlate,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Review section card for one garment type with edit button.
class ReviewSectionCard extends StatelessWidget {
  final String icon;
  final String title;
  final int stepIndex;
  final List<Map<String, String>> items;
  final ValueChanged<int> onEdit;

  const ReviewSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.stepIndex,
    required this.items,
    required this.onEdit,
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
          _buildHeader(),
          const SizedBox(height: 14),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 14),
          _buildGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(child: AppImage(image: icon, height: 20, width: 20)),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => onEdit(stepIndex),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.divider, width: 1),
            ),
            child: const Text(
              "تعديل",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: AppColors.textSlateSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGrid() {
    final rows = <Widget>[];
    for (int i = 0; i < items.length; i += 2) {
      rows.add(
        Row(
          children: [
            Expanded(child: _MeasurementTile(item: items[i])),
            const SizedBox(width: 12),
            if (i + 1 < items.length)
              Expanded(child: _MeasurementTile(item: items[i + 1]))
            else
              const Expanded(child: SizedBox()),
          ],
        ),
      );
      if (i + 2 < items.length) rows.add(const SizedBox(height: 12));
    }
    return Column(children: rows);
  }
}

class _MeasurementTile extends StatelessWidget {
  final Map<String, String> item;
  const _MeasurementTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final label = item.keys.first;
    final value = item.values.first;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubtle,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: "Inter",
              color: AppColors.textSlate,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "$value سم",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: "Inter",
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Info notice banner at the bottom of the review step.
class ReviewInfoNotice extends StatelessWidget {
  const ReviewInfoNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          AppImage(
            image: "mark.svg",
            height: 20,
            width: 20,
            color: AppColors.warningText,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "سيتواصل معك خياطنا لتأكيد القياسات قبل البدء في التفصيل",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter",
                color: AppColors.warningText,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
