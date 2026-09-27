import 'package:waheed/features/checkout/models/payment_card.dart';

/// Interface for loading and saving payment cards.
///
/// Replace the in-memory implementation with a real backend / payment
/// gateway integration (Stripe, Paymob, etc.) when available.
abstract class PaymentRepository {
  Future<List<PaymentCard>> getCards();
  Future<void> saveCard(PaymentCard card);
}

/// In-memory implementation seeded with two test cards.
///
/// This exists so the UI can be developed and tested before a real
/// payment backend is available.
class InMemoryPaymentRepository implements PaymentRepository {
  final List<PaymentCard> _cards = [
    const PaymentCard(
      id: 'mc_4242',
      brand: CardBrand.mastercard,
      holderName: 'أحمد محمد',
      last4: '4242',
    ),
    const PaymentCard(
      id: 'visa_6589',
      brand: CardBrand.visa,
      holderName: 'أحمد محمد',
      last4: '6589',
    ),
  ];

  @override
  Future<List<PaymentCard>> getCards() async => List.of(_cards);

  @override
  Future<void> saveCard(PaymentCard card) async {
    _cards.add(card);
  }
}
