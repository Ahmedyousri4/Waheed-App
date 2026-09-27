import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/core/widgets/product_card.dart';
import 'package:waheed/features/suit_measurements/suit_measurements_screen.dart';

/// Horizontal scroll of similar products.
class SimilarProductsSection extends StatelessWidget {
  const SimilarProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  AppImage(image: "similar.svg", height: 20, width: 20),
                  SizedBox(width: 8),
                  Text(
                    "منتجات مشابهة",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    "عرض الكل",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter",
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_back_ios,
                    size: 11,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 320,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: index < 3 ? 14 : 0),
                child: const SizedBox(
                  width: 170,
                  child: ProductCard(
                    image: "blacktwo.png",
                    title: "بدلة سوداء ثلاثية القطع",
                    subtitle: "كلاسيك",
                    price: "2,100",
                    rating: "4.9",
                    reviews: "2400",
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Bottom purchase bar with price, quantity, and CTA button.
class BottomPurchaseBar extends StatelessWidget {
  final String productImage;
  final String productTitle;
  final String productSubtitle;
  final String productPrice;

  const BottomPurchaseBar({
    super.key,
    this.productImage = 'blacksuit.png',
    this.productTitle = 'بدلة رجالية رمادي فاخرة',
    this.productSubtitle = 'صوف إيطالي فاخر',
    this.productPrice = '1,800',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "إجمالي السعر",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Inter",
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: const [
                      Text(
                        "ج",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        "1,800",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter",
                          color: AppColors.textPrimary,
                          height: 1,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "ج.2,200",
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: "Inter",
                          color: AppColors.textSecondary,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const _QuantitySelector(),
            ],
          ),
          const SizedBox(height: 16),
          _buildPurchaseButton(context),
        ],
      ),
    );
  }

  Widget _buildPurchaseButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SuitMeasurementsScreen(
                  productImage: productImage,
                  productTitle: productTitle,
                  productSubtitle: productSubtitle,
                  productPrice: productPrice,
                ),
              ),
            ),
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage(
                image: "size.svg",
                height: 20,
                width: 20,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "المتابعة لتحديد المقاسات",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// +/- quantity selector with animated number.
class _QuantitySelector extends StatefulWidget {
  const _QuantitySelector();

  @override
  State<_QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<_QuantitySelector> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubtle,
        border: Border.all(color: const Color(0xFFEAEAEA), width: 1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => setState(() => _qty++),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
          SizedBox(
            width: 36,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder:
                    (child, anim) => ScaleTransition(scale: anim, child: child),
                child: Text(
                  "$_qty",
                  key: ValueKey(_qty),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (_qty > 1) setState(() => _qty--);
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 1.5),
              ),
              child: const Icon(
                Icons.remove,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
