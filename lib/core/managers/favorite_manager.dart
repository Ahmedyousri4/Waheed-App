import 'package:flutter/material.dart';

/// Manages the favorites state using ValueNotifier.
///
/// Products are stored as `Map<String, dynamic>` for backwards
/// compatibility with existing favorite rendering.
class FavoriteManager {
  static final ValueNotifier<List<Map<String, dynamic>>> favoritesNotifier =
      ValueNotifier([]);

  static void toggleFavorite(Map<String, dynamic> product) {
    final favorites = List<Map<String, dynamic>>.from(favoritesNotifier.value);
    final index = favorites.indexWhere(
      (p) => p['image'] == product['image'] && p['title'] == product['title'],
    );
    if (index != -1) {
      favorites.removeAt(index);
    } else {
      favorites.add(product);
    }
    favoritesNotifier.value = favorites;
  }

  static bool isFavorite(String image, String title) {
    return favoritesNotifier.value.any(
      (p) => p['image'] == image && p['title'] == title,
    );
  }
}
