import 'package:flutter/material.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/models/branch_model.dart';
import 'package:waheed/features/checkout/utils/booking_confirmation_styles.dart';

/// Detailed information card showing branch location, appointment time,
/// and tailoring progress status (Figma node 3526:6244).
class BookingDetailsCard extends StatelessWidget {
  final BranchModel branch;
  final String appointmentDate;
  final String appointmentTime;
  final String tailoringStatus;
  final String tailoringSubline;

  const BookingDetailsCard({
    super.key,
    required this.branch,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.tailoringStatus,
    required this.tailoringSubline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: BookingConfirmationStyles.cardBorder,
          width: 0.8,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildRow(
            icon: 'store.svg',
            iconColor: const Color(0xFF1E3A8A),
            tileColor: BookingConfirmationStyles.tileNavyBg,
            label: 'فرع الاستلام',
            title: branch.name,
            subtitle: branch.address,
            subtitleStyle: BookingConfirmationStyles.detailSubtitle,
          ),
          _buildDashedDivider(),
          _buildRow(
            icon: 'calendar.svg',
            iconColor: const Color(0xFF1E3A8A),
            tileColor: BookingConfirmationStyles.tileNavyBg,
            label: 'موعد الاستلام',
            title: appointmentDate,
            subtitle: appointmentTime,
            subtitleStyle: BookingConfirmationStyles.detailSubtitle,
          ),
          _buildDashedDivider(),
          _buildRow(
            icon: 'scissors.svg',
            iconColor: BookingConfirmationStyles.goldAccent,
            tileColor: BookingConfirmationStyles.tileGoldBg,
            label: 'حالة التفصيل',
            title: tailoringStatus,
            subtitle: tailoringSubline,
            subtitleStyle: BookingConfirmationStyles.tailoringSubline,
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String icon,
    required Color iconColor,
    required Color tileColor,
    required String label,
    required String title,
    required String subtitle,
    required TextStyle subtitleStyle,
  }) {
    return Row(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: AppImage(
              image: icon,
              width: 20,
              height: 20,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label,
                style: BookingConfirmationStyles.detailLabel,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: BookingConfirmationStyles.detailTitle,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: subtitleStyle,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDashedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: LayoutBuilder(
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
                  color: BookingConfirmationStyles.cardBorder,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
