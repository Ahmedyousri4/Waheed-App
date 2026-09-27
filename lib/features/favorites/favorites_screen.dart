import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_back_button.dart';
import 'package:waheed/core/widgets/product_card.dart';
import 'package:waheed/core/managers/favorite_manager.dart';
import 'package:waheed/features/product_details/product_details_screen.dart';

/// Favorites listing screen. Shows products the user has liked.
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppBackButton(onTap: () => Navigator.pop(context)),
        ),
        centerTitle: true,
        title: const Text(
          "المفضلة",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
            color: Colors.black,
          ),
        ),
      ),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: FavoriteManager.favoritesNotifier,
        builder: (context, favorites, child) {
          if (favorites.isEmpty) {
            return const Center(
              child: Text(
                "لا توجد منتجات في المفضلة",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                  color: AppColors.textMuted,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            physics: const BouncingScrollPhysics(),
            itemCount: (favorites.length / 2).ceil(),
            itemBuilder: (context, index) {
              final first = favorites[index * 2];
              final second =
                  index * 2 + 1 < favorites.length
                      ? favorites[index * 2 + 1]
                      : null;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ProductCard(
                        image: first['image'] ?? '',
                        title: first['title'] ?? '',
                        subtitle: first['subtitle'] ?? '',
                        price: first['price'] ?? '',
                        rating: first['rating'] ?? '',
                        reviews: first['reviews'] ?? '',
                        heroTag:
                            first['heroTag'] != null
                                ? '${first['heroTag']}_fav_${index * 2}'
                                : null,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProductDetailsScreen(),
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    if (second != null)
                      Expanded(
                        child: ProductCard(
                          image: second['image'] ?? '',
                          title: second['title'] ?? '',
                          subtitle: second['subtitle'] ?? '',
                          price: second['price'] ?? '',
                          rating: second['rating'] ?? '',
                          reviews: second['reviews'] ?? '',
                          heroTag:
                              second['heroTag'] != null
                                  ? '${second['heroTag']}_fav_${index * 2 + 1}'
                                  : null,
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProductDetailsScreen(),
                                ),
                              ),
                        ),
                      )
                    else
                      const Expanded(child: SizedBox()),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
