import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/models/payment_card.dart';

class PaymentCardTile extends StatelessWidget {
  final PaymentCard card;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentCardTile({
    super.key,
    required this.card,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.black : AppColors.borderLight,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: AppImage(
                  image: card.brand.svgAsset,
                  height: 24,
                  width: 24,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.brand.displayName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'ينتهي بـ ${card.last4}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontFamily: 'Inter',
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            _buildRadio(),
          ],
        ),
      ),
    );
  }

  Widget _buildRadio() {
    if (isSelected) {
      return Container(
        height: 22,
        width: 22,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.black,
        ),
        child: const Icon(Icons.check, size: 14, color: Colors.white),
      );
    }
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.divider, width: 2),
      ),
    );
  }
}
