import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/features/checkout/widgets/checkout_section_header.dart';

/// Displays the "ملخص الطلب" section with pricing rows.
class OrderSummarySection extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;

  const OrderSummarySection({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CheckoutSectionHeader(icon: 'box.svg', title: 'ملخص الطلب'),
          const SizedBox(height: 16),
          _OrderSummaryRow(
            label: 'المجموع الفرعي',
            value: '${subtotal.toStringAsFixed(0)} ج.م',
          ),
          const SizedBox(height: 10),
          _OrderSummaryRow(
            label: 'التوصيل',
            value:
                deliveryFee > 0
                    ? '${deliveryFee.toStringAsFixed(0)} ج.م'
                    : 'مجاناً',
          ),
          const SizedBox(height: 10),
          _OrderSummaryRow(
            label: 'الخصم',
            value: discount > 0 ? '${discount.toStringAsFixed(0)} ج.م' : '—',
          ),
          const SizedBox(height: 12),
          // Dashed divider (matching cart_screen pattern)
          LayoutBuilder(
            builder: (context, constraints) {
              const dash = 6.0, gap = 4.0;
              final count = (constraints.maxWidth / (dash + gap)).floor();
              return Row(
                children: List.generate(
                  count,
                  (_) => Padding(
                    padding: const EdgeInsets.only(right: gap),
                    child: Container(
                      width: dash,
                      height: 1,
                      color: AppColors.pageIndicator,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${total.toStringAsFixed(0)} ج.م',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Inter',
                  color: Colors.black,
                ),
              ),
              const Text(
                'الإجمالي',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Single pricing row in the order summary.
class _OrderSummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _OrderSummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            color: Colors.black,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            color: Color(0xFF808080),
          ),
        ),
      ],
    );
  }
}
