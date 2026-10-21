import 'package:flutter/material.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/utils/booking_confirmation_styles.dart';

/// Fixed bottom action bar for Booking Confirmation (Figma node 3526:6320).
///
/// Contains two equal-width buttons:
/// - "تتبع الطلب" (Primary black button, functionally inert per current product scope)
/// - "الرئيسية" (Secondary outlined button with home icon, navigating back to home)
class BookingConfirmationFooter extends StatelessWidget {
  final VoidCallback onReturnHome;

  const BookingConfirmationFooter({super.key, required this.onReturnHome});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: BookingConfirmationStyles.cardBorder,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            // Left button: "تتبع الطلب" — rendered per Figma spec, functionally inert
            Expanded(
              child: Semantics(
                button: true,
                enabled: false,
                label: 'تتبع الطلب',
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 7.5,
                        color: Color(0x1A000000),
                      ),
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 3,
                        color: Color(0x1A000000),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'تتبع الطلب',
                    style: BookingConfirmationStyles.buttonText(
                      color: Colors.white,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Right button: "الرئيسية" — returns to HomeScreen
            Expanded(
              child: SizedBox(
                height: 56,
                child: OutlinedButton(
                  onPressed: onReturnHome,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    side: const BorderSide(color: Colors.black, width: 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.ltr,
                    children: [
                      Text(
                        'الرئيسية',
                        style: BookingConfirmationStyles.buttonText(
                          color: Colors.black,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(width: 8),
                      const AppImage(
                        image: 'home.svg',
                        width: 20,
                        height: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
