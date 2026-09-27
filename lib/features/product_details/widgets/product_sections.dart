import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';

/// Hero product image with "تفصيل على المقاس" badge overlay.
class ProductImageSection extends StatelessWidget {
  const ProductImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Hero(
            tag: "blacksuit.png",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const SizedBox(
                width: double.infinity,
                height: 340,
                child: AppImage(image: "blacksuit.png", fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppImage(
                    image: "size.svg",
                    height: 15,
                    width: 15,
                    color: Colors.white,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "تفصيل على المقاس",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal gallery of 4 product thumbnail images.
class ProductGallery extends StatelessWidget {
  const ProductGallery({super.key});

  static const _images = [
    "blackfour.png",
    "blackthree.png",
    "blacktwo.png",
    "blackone.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            _images
                .map(
                  (img) => ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AppImage(
                      image: img,
                      width: 82,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}

/// Product info: category label, name, rating row.
class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "بدلة كلاسيكية",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
            color: AppColors.gold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "بدلة رجالية رمادي فاخرة",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            color: AppColors.textPrimary,
            height: 1.3,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.star_rounded, color: AppColors.gold, size: 20),
            SizedBox(width: 5),
            Text(
              "4.8",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(width: 6),
            Text(
              "(124 تقييم)",
              style: TextStyle(
                fontSize: 13,
                fontFamily: "Inter",
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
