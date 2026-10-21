import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/features/checkout/widgets/checkout_section_header.dart';

/// Delivery method options.
enum DeliveryMethod { standard, express }

/// Displays the "طريقة التوصيل" section with selectable delivery cards.
class DeliveryMethodSection extends StatelessWidget {
  final DeliveryMethod selected;
  final ValueChanged<DeliveryMethod> onChanged;
  final double standardPrice;
  final double expressPrice;

  const DeliveryMethodSection({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.standardPrice,
    required this.expressPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckoutSectionHeader(
          icon: 'truckfast.svg',
          title: 'طريقة التوصيل',
        ),
        const SizedBox(height: 14),
        _DeliveryMethodCard(
          title: 'التوصيل العادي',
          duration: '٣ - ٥ أيام عمل',
          price: '${standardPrice.toStringAsFixed(0)} ج.م',
          isSelected: selected == DeliveryMethod.standard,
          onTap: () => onChanged(DeliveryMethod.standard),
        ),
        const SizedBox(height: 10),
        _DeliveryMethodCard(
          title: 'التوصيل السريع',
          duration: '١ - ٢ يوم عمل',
          price: '${expressPrice.toStringAsFixed(0)} ج.م',
          isSelected: selected == DeliveryMethod.express,
          onTap: () => onChanged(DeliveryMethod.express),
          badge: 'جديد',
        ),
      ],
    );
  }
}

/// Individual selectable delivery-method card.
class _DeliveryMethodCard extends StatelessWidget {
  final String title;
  final String duration;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;
  final String? badge;

  const _DeliveryMethodCard({
    required this.title,
    required this.duration,
    required this.price,
    required this.isSelected,
    required this.onTap,
    this.badge,
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
              child:
                  isSelected
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
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xE545AA7B),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badge!,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 11,
                      fontFamily: 'Inter',
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Price
            Text(
              price,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
