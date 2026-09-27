import 'package:flutter/material.dart';

/// Manages the shopping cart state using ValueNotifier.
///
/// Products are stored as `Map<String, dynamic>` for backwards
/// compatibility with existing cart item rendering.
class CartManager {
  static final ValueNotifier<List<Map<String, dynamic>>> cartNotifier =
      ValueNotifier([]);

  /// Add a product or increment its quantity if already in cart.
  static void addToCart(Map<String, dynamic> product) {
    final cart = List<Map<String, dynamic>>.from(cartNotifier.value);
    final index = cart.indexWhere(
      (p) => p['image'] == product['image'] && p['title'] == product['title'],
    );
    if (index != -1) {
      cart[index] = {...cart[index], 'quantity': cart[index]['quantity'] + 1};
    } else {
      cart.add({...product, 'quantity': 1});
    }
    cartNotifier.value = cart;
  }

  /// Remove one unit, or delete the item if quantity reaches 0.
  static void decrementOrRemove(String image, String title) {
    final cart = List<Map<String, dynamic>>.from(cartNotifier.value);
    final index = cart.indexWhere(
      (p) => p['image'] == image && p['title'] == title,
    );
    if (index == -1) return;
    if (cart[index]['quantity'] > 1) {
      cart[index] = {...cart[index], 'quantity': cart[index]['quantity'] - 1};
    } else {
      cart.removeAt(index);
    }
    cartNotifier.value = cart;
  }

  /// Completely remove an item regardless of quantity.
  static void removeFromCart(String image, String title) {
    final cart = List<Map<String, dynamic>>.from(cartNotifier.value);
    cart.removeWhere((p) => p['image'] == image && p['title'] == title);
    cartNotifier.value = cart;
  }

  static bool isInCart(String image, String title) {
    return cartNotifier.value.any(
      (p) => p['image'] == image && p['title'] == title,
    );
  }

  static int itemCount() => cartNotifier.value.fold(
    0,
    (sum, item) => sum + (item['quantity'] as int),
  );
}
