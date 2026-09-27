/// Typed data class replacing `Map<String, dynamic>` for products.
///
/// Used by ProductCard, CartManager, FavoriteManager, and anywhere
/// product data is passed around.
class Product {
  final String image;
  final String title;
  final String subtitle;
  final String price;
  final String rating;
  final String reviews;
  final String? heroTag;

  const Product({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.reviews,
    this.heroTag,
  });

  /// Parse the price string (e.g. "2,450") into a numeric value.
  double get numericPrice => double.tryParse(price.replaceAll(',', '')) ?? 0;

  Map<String, dynamic> toMap() => {
    'image': image,
    'title': title,
    'subtitle': subtitle,
    'price': price,
    'rating': rating,
    'reviews': reviews,
    'heroTag': heroTag,
  };
}
