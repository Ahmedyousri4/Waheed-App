import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/widgets/success_emblem.dart';
import 'package:waheed/features/home/home_screen.dart';

/// Order-confirmation success screen — Figma node 3526:5447.
///
/// Displays the confirmed order number, delivery estimate, and
/// two actions: "Track Order" (currently inactive) and "Return Home".
///
/// All screen-specific colors are defined as local constants to
/// avoid polluting the global [AppColors] palette.
class SuccessScreen extends StatelessWidget {
  /// The confirmed order number to display (e.g. "EQ-815069").
  final String orderNumber;

  /// The delivery estimate text (e.g. "٣–٥ أيام عمل").
  final String deliveryEstimate;

  const SuccessScreen({
    super.key,
    required this.orderNumber,
    required this.deliveryEstimate,
  });

  // ── Screen-local color constants (Figma spec, not in AppColors) ──

  /// Navy decoration: Figma #1E3A8A at 10% opacity.
  static const Color _navyDecoration = Color(0xFF1E3A8A);

  /// Heading text: Figma #0F172B.
  static const Color _headingColor = Color(0xFF0F172B);

  /// Body/label text: Figma #62748E.
  static const Color _bodyColor = Color(0xFF62748E);

  /// Order number text: Figma #292D32.
  static const Color _orderNumberColor = Color(0xFF292D32);

  /// Secondary button border: Figma rgba(30,58,138,0.19).
  static const Color _secondaryBorder = Color(0x301E3A8A);

  // ── Typography helpers (Cairo substitute for IBM Plex Sans Arabic) ─

  static const String _fontFamily = 'Cairo';

  static TextStyle _headingStyle() => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 36 / 24,
    color: _headingColor,
  );

  static TextStyle _bodyStyle() => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 22.75 / 14,
    color: _bodyColor,
  );

  static TextStyle _labelStyle() => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 16 / 12,
    color: _bodyColor,
  );

  static TextStyle _orderNumberStyle() => const TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 24 / 16,
    letterSpacing: 1,
    color: _orderNumberColor,
  );

  static TextStyle _buttonLabelStyle({required Color color}) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
    color: color,
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Prevent swiping back to the order-review screen after
      // confirmation. The user must explicitly use the home button.
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _buildUpperDecoration(),
            _buildLowerDecoration(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Spacer(flex: 3),
                    const SuccessEmblem(),
                    const SizedBox(height: 24),
                    Text(
                      'تم تأكيد طلبك بنجاح',
                      style: _headingStyle(),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'شكراً لاختيارك متجرنا. سنرسل لك إشعاراً عند شحن طلبك',
                      style: _bodyStyle(),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 32),
                    _buildOrderCard(),
                    const Spacer(flex: 4),
                    _buildTrackOrderButton(),
                    const SizedBox(height: 8),
                    _buildReturnHomeButton(context),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Upper-right navy circle (Figma: 256×256, x 224.8, y -80).
  Widget _buildUpperDecoration() {
    return Positioned(
      right: -80,
      top: -80,
      child: Container(
        width: 256,
        height: 256,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _navyDecoration.withValues(alpha: 0.1),
        ),
      ),
    );
  }

  /// Lower-left gold circle (Figma: 256×256, x -80, y 636.8).
  Widget _buildLowerDecoration() {
    return Positioned(
      left: -80,
      bottom: -80,
      child: Container(
        width: 256,
        height: 256,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.gold.withValues(alpha: 0.1),
        ),
      ),
    );
  }

  Widget _buildOrderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceSubtle,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.surfaceLight,
          width: 0.8,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'رقم الطلب',
            style: _labelStyle(),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 4),
          Text(
            orderNumber,
            style: _orderNumberStyle(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              const double dash = 6;
              const double gap = 4;
              final count = (constraints.maxWidth / (dash + gap)).floor();
              return Row(
                children: List.generate(
                  count,
                  (_) => Padding(
                    padding: const EdgeInsets.only(right: gap),
                    child: Container(
                      width: dash,
                      height: 0.8,
                      color: AppColors.divider,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'التوصيل المتوقع: $deliveryEstimate',
                style: _labelStyle(),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(width: 6),
              const AppImage(image: 'truckfast.svg', width: 16, height: 16),
            ],
          ),
        ],
      ),
    );
  }

  /// Primary "Track Order" button — rendered per Figma spec but
  /// functionally inactive. No tracking screen exists yet.
  Widget _buildTrackOrderButton() {
    return Container(
      width: double.infinity,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'تتبع الطلب',
            style: _buttonLabelStyle(color: Colors.white),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(width: 8),
          const AppImage(
            image: 'truckfast.svg',
            width: 20,
            height: 20,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  /// Secondary "Return Home" button — clears the checkout navigation
  /// stack and returns the user to [HomeScreen].
  Widget _buildReturnHomeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _secondaryBorder, width: 0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'العودة للرئيسية',
          style: _buttonLabelStyle(color: Colors.black),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
