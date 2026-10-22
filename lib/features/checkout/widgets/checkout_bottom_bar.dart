import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';

/// Bottom bar for the checkout screen with total price + submit button.
///
/// Matches the visual pattern of cart_screen's bottom bar while
/// adding loading/disabled states for order submission.
class CheckoutBottomBar extends StatelessWidget {
  final double total;
  final bool isSubmitting;
  final VoidCallback? onCheckout;

  const CheckoutBottomBar({
    super.key,
    required this.total,
    required this.isSubmitting,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: isSubmitting ? null : onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                disabledBackgroundColor: AppColors.black.withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child:
                  isSubmitting
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Text(
                        'إتمام الطلب',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                          color: Colors.white,
                        ),
                      ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'إجمالي السعر',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'Inter',
                  color: Color(0xFF808080),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${total.toStringAsFixed(0)} ج.م',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
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
