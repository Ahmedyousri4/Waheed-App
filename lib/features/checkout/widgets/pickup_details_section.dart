import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/models/branch_model.dart';
import 'package:waheed/features/checkout/widgets/checkout_section_header.dart';

/// "تفاصيل الاستلام" section — displayed when the user selects
/// "استلام من الفرع".
///
/// Shows the selected branch name and address.
class PickupDetailsSection extends StatelessWidget {
  final BranchModel branch;

  const PickupDetailsSection({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckoutSectionHeader(
          icon: 'location.svg',
          title: 'تفاصيل الاستلام',
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderLight, width: 1.5),
          ),
          child: Row(
            children: [
              // ── Branch info ──
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      branch.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      branch.address,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // ── Branch icon ──
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: AppImage(
                    image: 'house.svg',
                    height: 20,
                    width: 20,
                    color: AppColors.navy,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
