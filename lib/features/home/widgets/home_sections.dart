import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/core/widgets/product_card.dart';
import 'package:waheed/features/product_details/product_details_screen.dart';

class CategoriesSection extends StatelessWidget {
  final VoidCallback onViewAll;
  const CategoriesSection({super.key, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "تسوق حسب التصنيف",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: onViewAll,
              child: const Text(
                "عرض الكل",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                  color: Color(0xFF808080),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 32,
            child: const Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CategoryItem(title: "بدلات", icon: "suits.svg"),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: CategoryItem(title: "قمصان", icon: "shirts.svg"),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CategoryItem(
                        title: "اكسسوارات",
                        icon: "accessories.svg",
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: CategoryItem(title: "أحذية", icon: "shoes.svg"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A single category item row with icon and title.
class CategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  const CategoryItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.borderLight, width: 1.5),
            ),
            child: AppImage(image: icon, height: 24, width: 24),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: "Inter",
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

/// "أحدث المنتجات" grid section.
class ProductsSection extends StatelessWidget {
  final VoidCallback onViewMore;
  const ProductsSection({super.key, required this.onViewMore});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "أحدث المنتجات",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: onViewMore,
              child: const Text(
                "عرض المزيد",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                  color: Color(0xFF808080),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ProductCard(
                image: "blacksuit.png",
                title: "بدلة كلاسيكية سوداء",
                subtitle: "صوف إيطالي فاخر",
                price: "2,450",
                rating: "4.9",
                reviews: "128",
                heroTag: "blacksuit.png",
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductDetailsScreen(
                          productImage: 'blacksuit.png',
                          productTitle: 'بدلة كلاسيكية سوداء',
                          productSubtitle: 'صوف إيطالي فاخر',
                          productPrice: '2,450',
                        ),
                      ),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: ProductCard(
                image: "bluesuit.png",
                title: "بدلة كلاسيكية سوداء",
                subtitle: "صوف إيطالي فاخر",
                price: "2,450",
                rating: "4.9",
                reviews: "128",
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ProductCard(
                image: "blacksuit.png",
                title: "بدلة كلاسيكية سوداء",
                subtitle: "صوف إيطالي فاخر",
                price: "2,450",
                rating: "4.9",
                reviews: "128",
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ProductCard(
                image: "bluesuit.png",
                title: "بدلة كلاسيكية سوداء",
                subtitle: "صوف إيطالي فاخر",
                price: "2,450",
                rating: "4.9",
                reviews: "128",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
