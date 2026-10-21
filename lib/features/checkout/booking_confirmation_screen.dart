import 'package:flutter/material.dart';
import 'package:waheed/features/checkout/models/branch_model.dart';
import 'package:waheed/features/checkout/utils/booking_confirmation_styles.dart';
import 'package:waheed/features/checkout/widgets/booking_card.dart';
import 'package:waheed/features/checkout/widgets/booking_confirmation_footer.dart';
import 'package:waheed/features/checkout/widgets/booking_confirmation_header.dart';
import 'package:waheed/features/checkout/widgets/booking_details_card.dart';
import 'package:waheed/features/home/home_screen.dart';

/// Booking Confirmation screen — Figma node 3526:6123 (تم التأكيد).
///
/// Composes the branch-pickup confirmation experience:
/// - [BookingConfirmationHeader]: Gradient banner, emblem, and headline
/// - [BookingCard]: Order number, copy action, presentation QR, and caption
/// - [BookingDetailsCard]: Branch location, appointment time, and tailoring status
/// - [BookingConfirmationFooter]: Inert tracking action and Return Home button
///
/// Wrapped in a [PopScope] to prevent accidental back-navigation into the
/// scheduling form after booking confirmation.
class BookingConfirmationScreen extends StatelessWidget {
  /// The confirmed booking/order number (e.g. "EQ-862334").
  final String orderNumber;

  /// The branch where pickup is scheduled.
  final BranchModel branch;

  /// Formatted appointment date (e.g. "الأربعاء، ٢٠ مايو").
  final String appointmentDate;

  /// Formatted appointment time (e.g. "١١:٠٠ ص").
  final String appointmentTime;

  /// Tailoring status headline (e.g. "قيد التحضير").
  final String tailoringStatus;

  /// Tailoring status subline (e.g. "جاهز خلال ٣ أيام").
  final String tailoringSubline;

  /// Optional callback invoked when tapping "الرئيسية".
  /// Defaults to navigating to [HomeScreen] via [Navigator.pushAndRemoveUntil].
  final VoidCallback? onReturnHome;

  const BookingConfirmationScreen({
    super.key,
    required this.orderNumber,
    required this.branch,
    required this.appointmentDate,
    required this.appointmentTime,
    this.tailoringStatus = 'قيد التحضير',
    this.tailoringSubline = 'جاهز خلال ٣ أيام',
    this.onReturnHome,
  });

  void _onReturnHome(BuildContext context) {
    if (onReturnHome != null) {
      onReturnHome!();
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: BookingConfirmationStyles.bgScreen,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BookingConfirmationHeader(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          BookingCard(orderNumber: orderNumber),
                          const SizedBox(height: 16),
                          BookingDetailsCard(
                            branch: branch,
                            appointmentDate: appointmentDate,
                            appointmentTime: appointmentTime,
                            tailoringStatus: tailoringStatus,
                            tailoringSubline: tailoringSubline,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BookingConfirmationFooter(
              onReturnHome: () => _onReturnHome(context),
            ),
          ],
        ),
      ),
    );
  }
}
