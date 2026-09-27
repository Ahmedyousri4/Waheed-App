import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// A single measurement input field with label, hint, ruler icon, and cm unit.
class MeasurementField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String placeholder;

  const MeasurementField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: "Inter",
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              hint,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: "Inter",
                color: AppColors.textSlate,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.surfaceSubtle,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider, width: 1),
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),
              const AppImage(
                image: "size.svg",
                height: 18,
                width: 18,
                color: AppColors.textSlate,
              ),
              const SizedBox(width: 10),
              IntrinsicWidth(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter",
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    hintText: placeholder,
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                      color: AppColors.textHint,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                "سم",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter",
                  color: AppColors.textSlate,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

/// Card containing all measurement fields for one step.
class MeasurementsCard extends StatelessWidget {
  final List<Map<String, dynamic>> fields;

  const MeasurementsCard({super.key, required this.fields});

  @override
  Widget build(BuildContext context) {
    if (fields.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "تخصيص المقاس",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(fields.length, (i) {
            return Column(
              children: [
                MeasurementField(
                  label: fields[i]['label'],
                  hint: fields[i]['desc'],
                  controller: fields[i]['controller'],
                  placeholder: fields[i]['placeholder'],
                ),
                if (i < fields.length - 1) const SizedBox(height: 16),
              ],
            );
          }),
        ],
      ),
    );
  }
}
