import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/managers/cart_manager.dart';
import 'package:waheed/core/widgets/app_back_button.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/models/address_model.dart';
import 'package:waheed/features/checkout/models/branch_model.dart';
import 'package:waheed/features/checkout/models/payment_card.dart';
import 'package:waheed/features/checkout/widgets/address_bottom_sheet.dart';
import 'package:waheed/features/checkout/widgets/checkout_section_header.dart';
import 'package:waheed/features/checkout/widgets/delivery_method_section.dart';
import 'package:waheed/features/checkout/widgets/payment_method_section.dart';
import 'package:waheed/features/checkout/widgets/pickup_details_section.dart';
import 'package:waheed/features/checkout/widgets/receiving_method_section.dart';
import 'package:waheed/features/checkout/success_screen.dart';

/// Data bundle passed from Checkout → Order Review.
class OrderReviewArgs {
  final ReceivingMethod receivingMethod;
  final AddressModel? address;
  final BranchModel? branch;
  final DeliveryMethod deliveryMethod;
  final PaymentMethod paymentMethod;
  final PaymentCard? selectedCard;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;

  const OrderReviewArgs({
    required this.receivingMethod,
    this.address,
    this.branch,
    required this.deliveryMethod,
    required this.paymentMethod,
    this.selectedCard,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  });
}

/// "مراجعة الطلب" — Order Review screen.
class OrderReviewScreen extends StatefulWidget {
  final OrderReviewArgs args;

  const OrderReviewScreen({super.key, required this.args});

  @override
  State<OrderReviewScreen> createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  late AddressModel? _address;
  bool _isSubmitting = false;
  bool _isSummaryExpanded = false;

  @override
  void initState() {
    super.initState();
    _address = widget.args.address;
  }

  // ── Address change ──────────────────────────────────────────────

  void _onChangeAddress() {
    showModalBottomSheet<AddressModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddressBottomSheet(currentAddress: _address),
    ).then((result) {
      if (result != null && mounted) {
        setState(() => _address = result);
      }
    });
  }

  // ── Order submission ────────────────────────────────────────────

  void _onConfirmOrder() {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    // TODO: Replace with real order repository / use-case call.
    // The order number and delivery estimate below should come from
    // the actual API response when the backend is integrated.
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isSubmitting = false);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => const SuccessScreen(
                // TODO: Replace with real order number from API response.
                orderNumber: 'EQ-000000',
                deliveryEstimate: '٣–٥ أيام عمل',
              ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = widget.args;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ReviewReceivingMethod(receivingMethod: args.receivingMethod),
                  const SizedBox(height: 20),

                  if (args.receivingMethod ==
                      ReceivingMethod.deliveryToHome) ...[
                    _ReviewAddressCard(
                      address: _address,
                      onChangeAddress: _onChangeAddress,
                    ),
                    const SizedBox(height: 20),
                  ],

                  if (args.receivingMethod ==
                          ReceivingMethod.pickupFromBranch &&
                      args.branch != null) ...[
                    PickupDetailsSection(branch: args.branch!),
                    const SizedBox(height: 20),
                  ],

                  _ReviewOrderSummary(
                    isExpanded: _isSummaryExpanded,
                    onToggle:
                        () => setState(
                          () => _isSummaryExpanded = !_isSummaryExpanded,
                        ),
                    subtotal: args.subtotal,
                    deliveryFee: args.deliveryFee,
                    discount: args.discount,
                    total: args.total,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          _ReviewBottomBar(
            total: args.total,
            isSubmitting: _isSubmitting,
            onConfirm: _onConfirmOrder,
          ),
        ],
      ),
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
            'مراجعة الطلب',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 44),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════
// SECTION WIDGETS
// ══════════════════════════════════════════════════════════════════

// ── 1. Receiving Method ──────────────────────────────────────────

class _ReviewReceivingMethod extends StatelessWidget {
  final ReceivingMethod receivingMethod;

  const _ReviewReceivingMethod({required this.receivingMethod});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckoutSectionHeader(icon: 'truck.svg', title: 'طريقة الاستلام'),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: ReceivingMethodCard(
                icon: 'truck.svg',
                title: 'توصيل للمنزل',
                subtitle: '٣-٧ أيام',
                isSelected: receivingMethod == ReceivingMethod.deliveryToHome,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ReceivingMethodCard(
                icon: 'location.svg',
                title: 'استلام من الفرع',
                subtitle: 'جاهز خلال ٣ أيام',
                isSelected: receivingMethod == ReceivingMethod.pickupFromBranch,
                showFreeBadge: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── 2. Address Card ──────────────────────────────────────────────

class _ReviewAddressCard extends StatelessWidget {
  final AddressModel? address;
  final VoidCallback onChangeAddress;

  const _ReviewAddressCard({
    required this.address,
    required this.onChangeAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onChangeAddress,
              child: const Text(
                'تغيير',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const CheckoutSectionHeader(
              icon: 'location.svg',
              title: 'عنوان التوصيل',
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (address != null) _buildAddressContent() else _buildNoAddress(),
      ],
    );
  }

  Widget _buildAddressContent() {
    final addr = address!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (addr.isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'افتراضي',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              Text(
                addr.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: AppImage(
                    image: 'house.svg',
                    height: 18,
                    width: 18,
                    color: AppColors.navy,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${addr.name} • ${addr.phone}',
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Inter',
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            addr.displayAddress,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Inter',
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoAddress() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight, width: 1.5),
      ),
      child: const Center(
        child: Text(
          'لم يتم اختيار عنوان',
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

// ── 3. Order Summary (expandable) ────────────────────────────────

class _ReviewOrderSummary extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final double subtotal;
  final double deliveryFee;
  final double discount;
  final double total;

  const _ReviewOrderSummary({
    required this.isExpanded,
    required this.onToggle,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isExpanded ? 0.5 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                  const CheckoutSectionHeader(
                    icon: 'box.svg',
                    title: 'ملخص الطلب',
                  ),
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState:
                isExpanded
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
            firstChild: _buildExpandedContent(context),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: CartManager.cartNotifier,
      builder: (context, cartItems, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            children: [
              ...cartItems.map((item) {
                final qty = item['quantity'] as int;
                final price = (item['price'] as num).toDouble();
                final lineTotal = price * qty;
                final name = (item['title'] ?? item['name'] ?? '') as String;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        '${lineTotal.toStringAsFixed(0)} ج.م',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'x$qty',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Inter',
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 8),

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

              _SummaryRow(
                label: 'المجموع الفرعي',
                value: '${subtotal.toStringAsFixed(0)} ج.م',
              ),
              const SizedBox(height: 8),
              _SummaryRow(
                label: 'التوصيل',
                value:
                    deliveryFee > 0
                        ? '${deliveryFee.toStringAsFixed(0)} ج.م'
                        : 'مجاناً',
              ),
              const SizedBox(height: 8),
              _SummaryRow(
                label: 'الخصم',
                value:
                    discount > 0 ? '${discount.toStringAsFixed(0)} ج.م' : '—',
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${total.toStringAsFixed(0)} ج.م',
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
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
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
}

// ── 4. Bottom Bar ────────────────────────────────────────────────

class _ReviewBottomBar extends StatelessWidget {
  final double total;
  final bool isSubmitting;
  final VoidCallback onConfirm;

  const _ReviewBottomBar({
    required this.total,
    required this.isSubmitting,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        MediaQuery.of(context).padding.bottom + 16,
      ),
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
            child: ElevatedButton.icon(
              onPressed: isSubmitting ? null : onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                disabledBackgroundColor: AppColors.black.withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              icon:
                  isSubmitting
                      ? const SizedBox.shrink()
                      : const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 20,
                      ),
              label:
                  isSubmitting
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Text(
                        'تأكيد الطلب',
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
                '${total.toStringAsFixed(0)} جنيه',
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
