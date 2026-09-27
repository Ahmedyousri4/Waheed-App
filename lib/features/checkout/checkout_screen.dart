import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/managers/cart_manager.dart';
import 'package:waheed/core/widgets/app_back_button.dart';
import 'package:waheed/features/checkout/data/payment_repository.dart';
import 'package:waheed/features/checkout/models/address_model.dart';
import 'package:waheed/features/checkout/models/branch_model.dart';
import 'package:waheed/features/checkout/models/payment_card.dart';
import 'package:waheed/features/checkout/sheets/payment_method_sheet.dart';
import 'package:waheed/features/checkout/widgets/receiving_method_section.dart';
import 'package:waheed/features/checkout/widgets/delivery_address_section.dart';
import 'package:waheed/features/checkout/widgets/delivery_method_section.dart';
import 'package:waheed/features/checkout/widgets/payment_method_section.dart';
import 'package:waheed/features/checkout/widgets/order_summary_section.dart';
import 'package:waheed/features/checkout/widgets/pickup_details_section.dart';
import 'package:waheed/features/checkout/order_review_screen.dart';
import 'package:waheed/features/checkout/widgets/checkout_bottom_bar.dart';

/// Checkout / إتمام الطلب screen.
///
/// Composes all checkout sections and manages the overall checkout state.
/// Individual UI sections are extracted into dedicated widget files.
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // ── State ──────────────────────────────────────────────────────────
  ReceivingMethod _receivingMethod = ReceivingMethod.deliveryToHome;
  DeliveryMethod _deliveryMethod = DeliveryMethod.standard;
  PaymentMethod _paymentMethod = PaymentMethod.cashOnDelivery;
  AddressModel? _selectedAddress;
  BranchModel _selectedBranch = BranchModel.defaultBranch;

  // ── Payment cards ─────────────────────────────────────────────────
  final PaymentRepository _paymentRepo = InMemoryPaymentRepository();
  List<PaymentCard> _cards = [];
  PaymentCard? _selectedCard;

  @override
  void initState() {
    super.initState();
    _loadPaymentCards();
  }

  Future<void> _loadPaymentCards() async {
    final cards = await _paymentRepo.getCards();
    if (mounted) setState(() => _cards = cards);
  }

  // ── Payment sheet flow ────────────────────────────────────────────

  Future<void> _openPaymentSheet() async {
    final previousMethod = _paymentMethod;
    setState(() => _paymentMethod = PaymentMethod.creditCard);

    final result = await showPaymentMethodSheet(
      context,
      cards: _cards,
      selectedCardId: _selectedCard?.id,
    );

    if (!mounted) return;

    if (result != null) {
      // User confirmed a card selection.
      setState(() {
        _selectedCard = result.selectedCard;
        _cards = result.cards;
      });
    } else {
      // User dismissed the sheet without confirming.
      // If no card was ever committed, revert to the previous method.
      if (_selectedCard == null) {
        setState(() => _paymentMethod = previousMethod);
      }
    }
  }

  // ── Pricing ────────────────────────────────────────────────────────
  double get _standardDeliveryFee => 60;
  double get _expressDeliveryFee => 100;
  double get _discount => 0;

  double get _deliveryFee {
    if (_receivingMethod == ReceivingMethod.pickupFromBranch) return 0;
    return _deliveryMethod == DeliveryMethod.express
        ? _expressDeliveryFee
        : _standardDeliveryFee;
  }

  double _subtotal(List<Map<String, dynamic>> items) =>
      items.fold(0, (sum, item) => sum + item['price'] * item['quantity']);

  double _total(List<Map<String, dynamic>> items) =>
      _subtotal(items) + _deliveryFee - _discount;

  // ── Validation ─────────────────────────────────────────────────────

  /// Whether the submit button should be enabled.
  bool get _canSubmit =>
      !(_paymentMethod == PaymentMethod.creditCard && _selectedCard == null);

  String? _validate(List<Map<String, dynamic>> items) {
    if (items.isEmpty) return 'السلة فارغة';
    if (_receivingMethod == ReceivingMethod.deliveryToHome &&
        _selectedAddress == null) {
      return 'يرجى إضافة عنوان التوصيل';
    }
    if (_paymentMethod == PaymentMethod.creditCard && _selectedCard == null) {
      return 'يرجى اختيار بطاقة الدفع';
    }
    return null;
  }

  void _onSubmitOrder(List<Map<String, dynamic>> items) {
    final error = _validate(items);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error, textAlign: TextAlign.center),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    // Navigate to Order Review instead of submitting directly.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderReviewScreen(
          args: OrderReviewArgs(
            receivingMethod: _receivingMethod,
            address: _selectedAddress,
            deliveryMethod: _deliveryMethod,
            paymentMethod: _paymentMethod,
            selectedCard: _selectedCard,
            subtotal: _subtotal(items),
            deliveryFee: _deliveryFee,
            discount: _discount,
            total: _total(items),
          ),
        ),
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: CartManager.cartNotifier,
      builder: (context, cartItems, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: _buildAppBar(),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReceivingMethodSection(
                        selected: _receivingMethod,
                        onChanged: (m) =>
                            setState(() => _receivingMethod = m),
                      ),
                      const SizedBox(height: 20),
                      if (_receivingMethod ==
                          ReceivingMethod.deliveryToHome) ...[
                        DeliveryAddressSection(
                          selectedAddress: _selectedAddress,
                          onAddressSelected: (addr) =>
                              setState(() => _selectedAddress = addr),
                        ),
                        const SizedBox(height: 20),
                        DeliveryMethodSection(
                          selected: _deliveryMethod,
                          onChanged: (m) =>
                              setState(() => _deliveryMethod = m),
                          standardPrice: _standardDeliveryFee,
                          expressPrice: _expressDeliveryFee,
                        ),
                        const SizedBox(height: 20),
                      ] else ...[
                        PickupDetailsSection(branch: _selectedBranch),
                        const SizedBox(height: 20),
                      ],
                      PaymentMethodSection(
                        selected: _paymentMethod,
                        onChanged: (m) =>
                            setState(() => _paymentMethod = m),
                        onCreditCardTap: _openPaymentSheet,
                        creditCardSubtitle: _selectedCard != null
                            ? '${_selectedCard!.brand.displayName} •••• ${_selectedCard!.last4}'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      OrderSummarySection(
                        subtotal: _subtotal(cartItems),
                        deliveryFee: _deliveryFee,
                        discount: _discount,
                        total: _total(cartItems),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              CheckoutBottomBar(
                total: _total(cartItems),
                isSubmitting: false,
                onCheckout:
                    _canSubmit ? () => _onSubmitOrder(cartItems) : null,
              ),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 64,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppBackButton(),
          const Text(
            "إتمام الطلب",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter",
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}
