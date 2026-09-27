import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/core/managers/cart_manager.dart';
import 'package:waheed/core/managers/favorite_manager.dart';

/// Product card used across home, latest products, favorites,
/// product details (similar), and any future product grid.
///
/// This is the SINGLE implementation — the duplicate that existed
/// in `home.dart` and `home_components.dart` has been eliminated.
class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String price;
  final String rating;
  final String reviews;
  final String? heroTag;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.reviews,
    this.heroTag,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = AppImage(image: image, fit: BoxFit.cover);
    if (heroTag != null) {
      imageWidget = Hero(tag: heroTag!, child: imageWidget);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildImageStack(imageWidget), _buildDetails(context)],
        ),
      ),
    );
  }

  Widget _buildImageStack(Widget imageWidget) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: AspectRatio(aspectRatio: 0.9, child: imageWidget),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: _FavoriteButton(
            image: image,
            title: title,
            subtitle: subtitle,
            price: price,
            rating: rating,
            reviews: reviews,
            heroTag: heroTag,
          ),
        ),
      ],
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRatingRow(),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              fontFamily: "Inter",
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              fontFamily: "Inter",
              color: AppColors.textMuted,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          _buildPriceRow(),
        ],
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "($reviews)",
          style: const TextStyle(fontSize: 10, color: AppColors.textMuted),
        ),
        const SizedBox(width: 4),
        Text(
          rating,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.star, color: AppColors.star, size: 14),
      ],
    );
  }

  Widget _buildPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                fontFamily: "Inter",
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 2),
            const Text(
              "ج.م",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        _CartButton(
          image: image,
          title: title,
          subtitle: subtitle,
          price: price,
        ),
      ],
    );
  }
}

/// Favorite toggle button in top-left of product card.
class _FavoriteButton extends StatelessWidget {
  final String image, title, subtitle, price, rating, reviews;
  final String? heroTag;

  const _FavoriteButton({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.reviews,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: FavoriteManager.favoritesNotifier,
      builder: (context, _, __) {
        final isFav = FavoriteManager.isFavorite(image, title);
        return GestureDetector(
          onTap: () {
            FavoriteManager.toggleFavorite({
              'image': image,
              'title': title,
              'subtitle': subtitle,
              'price': price,
              'rating': rating,
              'reviews': reviews,
              'heroTag': heroTag,
            });
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              size: 18,
              color: isFav ? Colors.red : Colors.black54,
            ),
          ),
        );
      },
    );
  }
}

/// Cart "إيجار" / "تمت الإضافة" button in the product card.
class _CartButton extends StatelessWidget {
  final String image, title, subtitle, price;

  const _CartButton({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: CartManager.cartNotifier,
      builder: (context, _, __) {
        final inCart = CartManager.isInCart(image, title);
        return GestureDetector(
          onTap: () {
            CartManager.addToCart({
              'image': image,
              'title': title,
              'subtitle': subtitle,
              'price': double.tryParse(price.replaceAll(',', '')) ?? 0,
              'type': 'إيجار',
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: inCart ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
            ),
            child: Text(
              inCart ? 'تمت الإضافة ✓' : 'إيجار',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
                color: inCart ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
