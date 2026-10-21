import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/features/checkout/models/payment_card.dart';
import 'package:waheed/features/checkout/sheets/new_payment_method_sheet.dart';
import 'package:waheed/features/checkout/widgets/dashed_add_button.dart';
import 'package:waheed/features/checkout/widgets/payment_card_tile.dart';
import 'package:waheed/features/checkout/widgets/primary_button.dart';
import 'package:waheed/features/checkout/widgets/sheet_header.dart';

// ──────────────────────────────────────────────────────────────────
// Result
// ──────────────────────────────────────────────────────────────────

/// Returned when the user confirms a card selection in Sheet 1.
class PaymentSheetResult {
  /// The card the user committed to.
  final PaymentCard selectedCard;

  /// The (possibly updated) list of cards — may include newly added ones.
  final List<PaymentCard> cards;

  const PaymentSheetResult({required this.selectedCard, required this.cards});
}

// ──────────────────────────────────────────────────────────────────
// Helper
// ──────────────────────────────────────────────────────────────────

/// Opens Sheet 1 — the "طريقة الدفع" saved-card picker.
///
/// Returns a [PaymentSheetResult] when the user taps "حفظ", or
/// `null` if dismissed without confirming.
Future<PaymentSheetResult?> showPaymentMethodSheet(
  BuildContext context, {
  required List<PaymentCard> cards,
  String? selectedCardId,
}) {
  return showModalBottomSheet<PaymentSheetResult>(
    context: context,
    enableDrag: false,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useSafeArea: true,
    builder:
        (_) =>
            _PaymentMethodSheet(cards: cards, selectedCardId: selectedCardId),
  );
}

// ──────────────────────────────────────────────────────────────────
// Sheet content
// ──────────────────────────────────────────────────────────────────

class _PaymentMethodSheet extends StatefulWidget {
  final List<PaymentCard> cards;
  final String? selectedCardId;

  const _PaymentMethodSheet({required this.cards, this.selectedCardId});

  @override
  State<_PaymentMethodSheet> createState() => _PaymentMethodSheetState();
}

class _PaymentMethodSheetState extends State<_PaymentMethodSheet> {
  late final List<PaymentCard> _cards;
  late String? _draftCardId;

  @override
  void initState() {
    super.initState();
    _cards = List.of(widget.cards);
    _draftCardId = widget.selectedCardId ?? _cards.firstOrNull?.id;
  }

  // ── Callbacks ───────────────────────────────────────────────────

  Future<void> _onAddCard() async {
    final newCard = await showNewPaymentMethodSheet(context);
    if (newCard != null && mounted) {
      setState(() {
        _cards.add(newCard);
        _draftCardId = newCard.id; // auto-select the new card
      });
    }
  }

  void _onSave() {
    if (_draftCardId == null) return;
    final selectedCard = _cards.firstWhere((c) => c.id == _draftCardId);
    Navigator.pop(
      context,
      PaymentSheetResult(selectedCard: selectedCard, cards: _cards),
    );
  }

  // ── Build ───────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsetsDirectional.fromSTEB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetHeader(
            title: 'طريقة الدفع',
            onClose: () => Navigator.pop(context),
          ),
          const SizedBox(height: 20),

          // ── Section title ──
          const Text(
            'الكروت المحفوظة',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              fontFamily: 'Inter',
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'اختر طريقة الدفع لهذا الطلب',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),

          // ── Card tiles ──
          ...List.generate(_cards.length, (index) {
            final card = _cards[index];
            return Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: index < _cards.length - 1 ? 10 : 0,
              ),
              child: PaymentCardTile(
                card: card,
                isSelected: card.id == _draftCardId,
                onTap: () => setState(() => _draftCardId = card.id),
              ),
            );
          }),
          const SizedBox(height: 12),

          // ── Add new card ──
          DashedAddButton(label: '+ إضافة كارت جديد', onTap: _onAddCard),
          const SizedBox(height: 20),

          // ── Save button ──
          PrimaryButton(
            label: 'حفظ',
            onPressed: _draftCardId != null ? _onSave : null,
          ),
        ],
      ),
    );
  }
}
