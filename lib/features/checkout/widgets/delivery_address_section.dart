import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/models/address_model.dart';
import 'package:waheed/features/checkout/widgets/address_bottom_sheet.dart';
import 'package:waheed/features/checkout/widgets/checkout_section_header.dart';

/// Displays the "عنوان التوصيل" section in the checkout screen.
///
/// Tapping opens a bottom sheet to view/add addresses.
class DeliveryAddressSection extends StatelessWidget {
  final AddressModel? selectedAddress;
  final ValueChanged<AddressModel> onAddressSelected;

  const DeliveryAddressSection({
    super.key,
    required this.selectedAddress,
    required this.onAddressSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckoutSectionHeader(
          icon: 'location.svg',
          title: 'عنوان التوصيل',
        ),
        const SizedBox(height: 14),
        selectedAddress != null
            ? _buildSelectedAddress(context)
            : _buildAddAddressButton(context),
      ],
    );
  }

  void _openAddressSheet(BuildContext context) {
    showModalBottomSheet<AddressModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddressBottomSheet(currentAddress: selectedAddress),
    ).then((result) {
      if (result != null) {
        onAddressSelected(result);
      }
    });
  }

  Widget _buildAddAddressButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _openAddressSheet(context),
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: AppColors.divider,
          borderRadius: 14,
          dashWidth: 6,
          dashGap: 4,
          strokeWidth: 1.5,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: const Column(
            children: [
              Icon(Icons.add, color: AppColors.textSecondary, size: 24),
              SizedBox(height: 6),
              Text(
                'إضافة عنوان جديد',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedAddress(BuildContext context) {
    return GestureDetector(
      onTap: () => _openAddressSheet(context),
      child: Container(
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
            // ── Row: house icon + المنزل + افتراضي badge ──
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // افتراضي badge
                if (selectedAddress!.isDefault)
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
                // المنزل label
                Text(
                  selectedAddress!.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 10),
                // House icon in circle
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
            // ── Name + Phone ──
            Text(
              '${selectedAddress!.name} • ${selectedAddress!.phone}',
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            // ── City, Area ──
            Text(
              selectedAddress!.displayAddress,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Paints a dashed rounded-rectangle border.
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  _DashedBorderPainter({
    required this.color,
    required this.borderRadius,
    required this.dashWidth,
    required this.dashGap,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end.toDouble()), paint);
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) =>
      old.color != color ||
      old.borderRadius != borderRadius ||
      old.dashWidth != dashWidth;
}
