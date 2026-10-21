import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/widgets/checkout_section_header.dart';

/// Receiving method options.
enum ReceivingMethod { pickupFromBranch, deliveryToHome }

/// Displays the "طريقة الاستلام" section with two selectable cards.
///
/// White background for both cards. Selected card gets a black border
/// and a gradient icon container (#314158 → #6A8CBE).
class ReceivingMethodSection extends StatelessWidget {
  final ReceivingMethod selected;
  final ValueChanged<ReceivingMethod> onChanged;

  const ReceivingMethodSection({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckoutSectionHeader(icon: 'truck.svg', title: 'طريقة الاستلام'),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: ReceivingMethodCard(
                icon: 'truck.svg',
                title: 'توصيل للمنزل',
                subtitle: '٣-٧ أيام',
                isSelected: selected == ReceivingMethod.deliveryToHome,
                onTap: () => onChanged(ReceivingMethod.deliveryToHome),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ReceivingMethodCard(
                icon: 'location.svg',
                title: 'استلام من الفرع',
                subtitle: 'جاهز خلال ٣ أيام',
                isSelected: selected == ReceivingMethod.pickupFromBranch,
                onTap: () => onChanged(ReceivingMethod.pickupFromBranch),
                showFreeBadge: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Individual selectable receiving-method card.
///
/// Reusable across Checkout and Order Review screens. When [onTap] is
/// `null` the card is rendered read-only (review mode).
class ReceivingMethodCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool showFreeBadge;

  const ReceivingMethodCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    this.onTap,
    this.showFreeBadge = false,
  });

  /// Selected-state gradient: #314158 → #6A8CBE
  static const _selectedGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF314158), Color(0xFF6A8CBE)],
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.black : AppColors.borderLight,
            width: isSelected ? 1.8 : 1.2,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // "مجاناً" badge (only on pickup card when selected)
                if (showFreeBadge && isSelected)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5EDD8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'مجاناً',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                        color: Color(0xFFC4A44E),
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),
                // Icon container — gradient when selected, light when not
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    gradient: isSelected ? _selectedGradient : null,
                    color: isSelected ? null : AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: AppImage(
                      image: icon,
                      height: 22,
                      width: 22,
                      color: isSelected ? Colors.white : AppColors.navy,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  color:
                      isSelected
                          ? AppColors.textPrimary
                          : AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: 'Inter',
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
