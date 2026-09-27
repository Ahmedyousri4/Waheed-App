import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/widgets/checkout_section_header.dart';

/// Payment method options.
enum PaymentMethod { cashOnDelivery, creditCard }

/// Displays the "طريقة الدفع" section with selectable payment cards.
///
/// Tapping **cash on delivery** calls [onChanged] directly.
/// Tapping **credit card** always calls [onCreditCardTap] to open the
/// card-selection sheet, even if credit card is already selected.
class PaymentMethodSection extends StatelessWidget {
  final PaymentMethod selected;
  final ValueChanged<PaymentMethod> onChanged;

  /// Called when the credit-card tile is tapped — should open Sheet 1.
  final VoidCallback onCreditCardTap;

  /// Override subtitle for the credit-card tile once a card is committed
  /// (e.g. "ماستر كارد •••• 4242"). Falls back to the default when `null`.
  final String? creditCardSubtitle;

  const PaymentMethodSection({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.onCreditCardTap,
    this.creditCardSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckoutSectionHeader(icon: 'card.svg', title: 'طريقة الدفع'),
        const SizedBox(height: 14),
        _PaymentMethodCard(
          icon: 'wallet.svg',
          title: 'الدفع عند الاستلام',
          subtitle: 'ادفع نقداً عند استلام الطلب',
          isSelected: selected == PaymentMethod.cashOnDelivery,
          onTap: () => onChanged(PaymentMethod.cashOnDelivery),
        ),
        const SizedBox(height: 10),
        _PaymentMethodCard(
          icon: 'cardd.svg',
          title: 'بطاقة ائتمانية / ميزة',
          subtitle: creditCardSubtitle ?? 'Visa, Mastercard, Meeza',
          isSelected: selected == PaymentMethod.creditCard,
          onTap: onCreditCardTap,
        ),
      ],
    );
  }
}

/// Individual selectable payment-method card.
class _PaymentMethodCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.icon,
    required this.title,
    required this.subtitle,
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
            // Selection radio
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.black : AppColors.divider,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.black,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            // Icon container
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: AppImage(
                  image: icon,
                  height: 20,
                  width: 20,
                  color: AppColors.navy,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      fontFamily: 'Inter',
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
