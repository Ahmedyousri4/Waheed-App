/// Card brand detected from the card number prefix.
enum CardBrand {
  visa,
  mastercard,
  unknown;

  /// Arabic display name for the brand.
  String get displayName => switch (this) {
        CardBrand.visa => 'فيزا',
        CardBrand.mastercard => 'ماستر كارد',
        CardBrand.unknown => 'بطاقة',
      };

  /// SVG asset file name for the brand logo.
  String get svgAsset => switch (this) {
        CardBrand.visa => 'visaelectron.svg',
        CardBrand.mastercard => 'mastercard.svg',
        CardBrand.unknown => 'card.svg',
      };
}

/// Represents a saved payment card.
///
/// SECURITY: Only the last 4 digits are stored. Full card numbers
/// and CVVs must **never** be persisted in state, models, or logs.
/// Real payments must go through a gateway SDK / tokenization
/// (e.g. Stripe, Paymob, Fawry, etc.).
class PaymentCard {
  final String id;
  final CardBrand brand;
  final String holderName;
  final String last4;
  final bool saveForFuture;

  const PaymentCard({
    required this.id,
    required this.brand,
    required this.holderName,
    required this.last4,
    this.saveForFuture = true,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentCard &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
