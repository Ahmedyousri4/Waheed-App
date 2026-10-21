import 'package:flutter/material.dart';
import 'package:waheed/features/checkout/utils/booking_confirmation_styles.dart';

/// Top header banner for Booking Confirmation (Figma node 3526:6124).
///
/// Features a dark diagonal gradient, two soft decorative gold circles,
/// the solid gold checkmark emblem, headline, and supporting copy.
class BookingConfirmationHeader extends StatelessWidget {
  const BookingConfirmationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            BookingConfirmationStyles.headerGradientStart,
            BookingConfirmationStyles.headerGradientEnd,
          ],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Upper-right decorative gold circle (176×176, 15% opacity)
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              width: 176,
              height: 176,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BookingConfirmationStyles.goldAccent.withValues(
                  alpha: 0.15,
                ),
              ),
            ),
          ),
          // Lower-left decorative gold circle (176×176, 10% opacity)
          Positioned(
            left: -40,
            bottom: -40,
            child: Container(
              width: 176,
              height: 176,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BookingConfirmationStyles.goldAccent.withValues(
                  alpha: 0.10,
                ),
              ),
            ),
          ),
          // Centered content
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Gold circular emblem with white checkmark
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: BookingConfirmationStyles.goldAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 20),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 44,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'تم تأكيد الحجز',
                      style: BookingConfirmationStyles.headerTitle,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'استلم بدلتك من الفرع في الموعد المحدد',
                      style: BookingConfirmationStyles.headerSubtitle,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
