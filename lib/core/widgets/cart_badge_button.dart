import 'package:flutter/material.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/app/theme/app_colors.dart';

/// Shopping cart icon with a badge showing the item count.
///
/// Reused in product details, latest products, and potentially
/// other screens that need a cart indicator.
class CartBadgeButton extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const CartBadgeButton({super.key, this.count = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Center(
              child: AppImage(image: "shoppingcart.svg", height: 20, width: 20),
            ),
          ),
          if (count > 0)
            Positioned(
              top: -2,
              left: -2,
              child: Container(
                height: 18,
                width: 18,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    "$count",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
