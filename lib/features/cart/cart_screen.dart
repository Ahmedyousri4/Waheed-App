import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/core/managers/cart_manager.dart';
import 'package:waheed/features/cart/widgets/cart_item_card.dart';
import 'package:waheed/features/checkout/checkout_screen.dart';

/// Cart screen with empty state, item list, coupon field,
/// order summary, and checkout bottom bar.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponController = TextEditingController();

  double get _delivery => 60;
  double get _discount => 0;

  double _subtotal(List<Map<String, dynamic>> items) =>
      items.fold(0, (sum, item) => sum + item['price'] * item['quantity']);

  double _total(List<Map<String, dynamic>> items) =>
      _subtotal(items) + _delivery - _discount;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: CartManager.cartNotifier,
      builder: (context, cartItems, _) {
        final isEmpty = cartItems.isEmpty;
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'عربة التسوق',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                fontFamily: 'Inter',
                color: Colors.black,
              ),
            ),
          ),
          body: isEmpty ? _buildEmptyState() : _buildFilledState(cartItems),
          bottomNavigationBar: isEmpty ? null : _buildBottomBar(cartItems),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppImage(image: 'cart.png', height: 180, width: 180),
            const SizedBox(height: 24),
            const Text(
              'عربة التسوق فارغة…',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 18,
                ),
                label: const Text(
                  'اذهب الى التسوق',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilledState(List<Map<String, dynamic>> cartItems) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...cartItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: CartItemCard(
                item: item,
                onIncrement: () => CartManager.addToCart(item),
                onDecrement:
                    () => CartManager.decrementOrRemove(
                      item['image'],
                      item['title'],
                    ),
                onDelete:
                    () => CartManager.removeFromCart(
                      item['image'],
                      item['title'],
                    ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildCouponRow(),
          const SizedBox(height: 16),
          _buildOrderSummary(cartItems),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildCouponRow() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
          child: const Text(
            'تطبيق',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderLight, width: 1.5),
            ),
            child: TextField(
              controller: _couponController,
              textAlign: TextAlign.right,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'أدخل كود الخصم',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  color: Color(0xFFAAAAAA),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppImage(image: 'copon.svg', height: 20, width: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary(List<Map<String, dynamic>> cartItems) {
    final sub = _subtotal(cartItems);
    final tot = _total(cartItems);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.keyboard_arrow_up_rounded, size: 22),
              Row(
                children: [
                  const Text(
                    'ملخص الطلب',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Inter',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AppImage(image: 'box.svg', height: 20, width: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _summaryRow('المجموع الفرعي', '${sub.toStringAsFixed(0)} ج.م'),
          const SizedBox(height: 10),
          _summaryRow('التوصيل', '${_delivery.toStringAsFixed(0)} ج.م'),
          const SizedBox(height: 10),
          _summaryRow(
            'الخصم',
            _discount > 0 ? '${_discount.toStringAsFixed(0)} ج.م' : '—',
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              const dash = 6.0, gap = 4.0;
              final count = (constraints.maxWidth / (dash + gap)).floor();
              return Row(
                children: List.generate(
                  count,
                  (_) => Padding(
                    padding: const EdgeInsets.only(right: gap),
                    child: Container(
                      width: dash,
                      height: 1,
                      color: AppColors.pageIndicator,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${tot.toStringAsFixed(0)} ج.م',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Inter',
                  color: Colors.black,
                ),
              ),
              const Text(
                'الإجمالي',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            color: Colors.black,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            color: Color(0xFF808080),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(List<Map<String, dynamic>> cartItems) {
    final tot = _total(cartItems);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CheckoutScreen()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'إتمام الطلب',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'إجمالي السعر',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'Inter',
                  color: Color(0xFF808080),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${tot.toStringAsFixed(0)} ج.م',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Inter',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
