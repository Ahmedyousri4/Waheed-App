import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/models/payment_card.dart';
import 'package:waheed/features/checkout/utils/card_validators.dart';
import 'package:waheed/features/checkout/utils/input_formatters.dart';
import 'package:waheed/features/checkout/widgets/app_text_field.dart';
import 'package:waheed/features/checkout/widgets/primary_button.dart';
import 'package:waheed/features/checkout/widgets/sheet_header.dart';

/// Opens Sheet 2 — the "طريقة دفع جديدة" add-card form.
///
/// Returns the newly created [PaymentCard] (with only `last4` —
/// full card number / CVV are **never** stored). Returns `null`
/// if the user dismisses the sheet without saving.
Future<PaymentCard?> showNewPaymentMethodSheet(BuildContext context) {
  return showModalBottomSheet<PaymentCard>(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    builder: (_) => const _NewPaymentMethodSheet(),
  );
}

// ──────────────────────────────────────────────────────────────────
// Sheet content
// ──────────────────────────────────────────────────────────────────

class _NewPaymentMethodSheet extends StatefulWidget {
  const _NewPaymentMethodSheet();

  @override
  State<_NewPaymentMethodSheet> createState() => _NewPaymentMethodSheetState();
}

class _NewPaymentMethodSheetState extends State<_NewPaymentMethodSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _saveForFuture = true;

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  // ── Save logic ──────────────────────────────────────────────────

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    final digits = _cardNumberController.text.replaceAll(' ', '');
    final brand = detectBrand(digits);
    final last4 = digits.substring(digits.length - 4);

    // SECURITY: Only last4 is stored. Full number and CVV are never
    // persisted — real payments must go through a gateway SDK.
    final card = PaymentCard(
      id: 'card_${DateTime.now().millisecondsSinceEpoch}',
      brand: brand,
      holderName: _nameController.text.trim(),
      last4: last4,
      saveForFuture: _saveForFuture,
    );

    Navigator.pop(context, card);
  }

  // ── Build ───────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    final bottomSafe = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        // Allows scrolling when the keyboard pushes content up.
        padding: EdgeInsetsDirectional.fromSTEB(
          20,
          16,
          20,
          bottomInsets + bottomSafe + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(
              title: 'طريقة دفع جديدة',
              onClose: () => Navigator.pop(context),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Holder name ──
                  _buildLabel('اسم حامل الكارت'),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: _nameController,
                    hint: 'الاسم',
                    validator: validateHolderName,
                  ),
                  const SizedBox(height: 16),

                  // ── Card number ──
                  _buildLabel('رقم الكارت'),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: _cardNumberController,
                    hint: '0000 0000 0000 0000',
                    keyboardType: TextInputType.number,
                    inputFormatters: [CardNumberFormatter()],
                    prefixIcon: const Padding(
                      padding: EdgeInsetsDirectional.only(start: 12, end: 8),
                      child: AppImage(
                        image: 'card.svg',
                        height: 20,
                        width: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    validator: validateCardNumber,
                  ),
                  const SizedBox(height: 16),

                  // ── CVV (start / right in RTL) + Expiry (end / left) ──
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('CVV'),
                            const SizedBox(height: 8),
                            AppTextField(
                              controller: _cvvController,
                              hint: '•••',
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                              validator:
                                  (v) => validateCvv(
                                    v,
                                    _cardNumberController.text,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('تاريخ الانتهاء'),
                            const SizedBox(height: 8),
                            AppTextField(
                              controller: _expiryController,
                              hint: 'MM/YY',
                              keyboardType: TextInputType.number,
                              inputFormatters: [ExpiryDateFormatter()],
                              validator: validateExpiry,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Save-for-future checkbox ──
                  GestureDetector(
                    onTap:
                        () => setState(() => _saveForFuture = !_saveForFuture),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color:
                                _saveForFuture
                                    ? AppColors.black
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color:
                                  _saveForFuture
                                      ? AppColors.black
                                      : AppColors.divider,
                              width: 1.5,
                            ),
                          ),
                          child:
                              _saveForFuture
                                  ? const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.white,
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'حفظ الكارت للمعاملات القادمة',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Inter',
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Save button ──
                  PrimaryButton(label: 'حفظ', onPressed: _onSave),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
        color: AppColors.textPrimary,
      ),
    );
  }
}
