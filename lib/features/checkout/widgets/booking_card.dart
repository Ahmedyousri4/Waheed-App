import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/utils/booking_confirmation_styles.dart';
import 'package:waheed/features/checkout/widgets/booking_confirmation_qr_visual.dart';

/// Main booking card displaying order number, copy control, QR presentation,
/// and branch presentation instructions (Figma node 3526:6135).
class BookingCard extends StatelessWidget {
  /// The confirmed booking/order number (e.g. "EQ-862334").
  final String orderNumber;

  const BookingCard({super.key, required this.orderNumber});

  void _onCopy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: orderNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ رقم الطلب', textAlign: TextAlign.center),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, 8),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        children: [
          // Order number and copy action row
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Copy button (on physical left)
              GestureDetector(
                onTap: () => _onCopy(context),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.ltr,
                  children: const [
                    AppImage(
                      image: 'copy.svg',
                      width: 14,
                      height: 14,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4),
                    Text(' نسخ', style: BookingConfirmationStyles.copyText),
                  ],
                ),
              ),
              // Order details (on physical right)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'رقم الطلب',
                    style: BookingConfirmationStyles.orderLabel,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    orderNumber,
                    style: BookingConfirmationStyles.orderNumber,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // QR presentation surface
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            decoration: BoxDecoration(
              color: BookingConfirmationStyles.subtleCardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: BookingConfirmationQrVisual()),
          ),
          const SizedBox(height: 12),

          // Instruction caption (miniature QR icon on physical left, text on physical right)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.ltr,
            children: const [
              AppImage(
                image: 'qrcode.svg',
                width: 14,
                height: 14,
                color: BookingConfirmationStyles.goldAccent,
              ),
              SizedBox(width: 6),
              Flexible(
                child: Text(
                  'اعرض هذا الرمز في الفرع للاستلام',
                  style: BookingConfirmationStyles.caption,
                  textDirection: TextDirection.rtl,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
