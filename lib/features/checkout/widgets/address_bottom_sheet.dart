import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/add_address_screen.dart';
import 'package:waheed/features/checkout/models/address_model.dart';

/// Bottom sheet that displays saved addresses and lets the user
/// pick one or add a new address.
///
/// Returns the selected [AddressModel] via Navigator.pop.
class AddressBottomSheet extends StatelessWidget {
  final AddressModel? currentAddress;

  const AddressBottomSheet({super.key, this.currentAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Handle bar ──
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // ── Header ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  size: 22,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(
                'عنوان التوصيل',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 22),
            ],
          ),
          const SizedBox(height: 20),

          // ── Section title ──
          Row(
            children: [
              const AppImage(
                image: 'location.svg',
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'عنوان التوصيل',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Inter',
                  color: AppColors.navy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // ── Saved address card ──
          if (currentAddress != null) _buildAddressCard(currentAddress!),

          const SizedBox(height: 12),

          // ── Add new address ──
          _buildAddNewButton(context),

          const SizedBox(height: 20),

          // ── Confirm button ──
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: currentAddress != null
                  ? () => Navigator.pop(context, currentAddress)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                disabledBackgroundColor: AppColors.black.withValues(alpha: 0.3),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تأكيد العنوان',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.navigation, size: 18, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(AddressModel address) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.textPrimary, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              // Default badge
              if (address.isDefault)
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
              const Spacer(),
              // Label
              Text(
                address.label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              // Home icon
              const Icon(Icons.home_outlined, size: 22, color: AppColors.navy),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${address.name} • ${address.phone}',
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Inter',
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            address.displayAddress,
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

  Widget _buildAddNewButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push<AddressModel>(
          context,
          MaterialPageRoute(builder: (_) => const AddAddressScreen()),
        );
        if (result != null && context.mounted) {
          Navigator.pop(context, result);
        }
      },
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
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: AppColors.textSecondary, size: 20),
              SizedBox(width: 8),
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
    final paint = Paint()
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
        canvas.drawPath(
          metric.extractPath(distance, end.toDouble()),
          paint,
        );
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
