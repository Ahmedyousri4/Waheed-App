import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/features/checkout/data/appointment_availability.dart';
import 'package:waheed/features/checkout/utils/choose_appointment_styles.dart';

// ── Figma-specific colours with no exact AppColors token ──────────────
// Spec §7: documented local values, not new shared tokens.

/// Three-column time-slot grid (Figma `3526:6061`, 322 × 147.963).
///
/// Slots are supplied in RTL reading order — the first entry renders at
/// the right of row 1, matching the captured design.
class AppointmentTimeGrid extends StatelessWidget {
  final List<AppointmentTimeSlot> slots;

  /// Display label of the selected slot, or `null`.
  final String? selectedLabel;

  final ValueChanged<String> onSelect;

  const AppointmentTimeGrid({
    super.key,
    required this.slots,
    required this.selectedLabel,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      // The parent `SingleChildScrollView` owns scrolling.
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        // Figma cell ≈ 102 × 43.988.
        childAspectRatio: 102 / 43.988,
      ),
      itemCount: slots.length,
      itemBuilder: (context, index) {
        final slot = slots[index];
        return _TimeSlotTile(
          slot: slot,
          isSelected: slot.isAvailable && slot.label == selectedLabel,
          // Unavailable slots are non-interactive.
          onTap: slot.isAvailable ? () => onSelect(slot.label) : null,
        );
      },
    );
  }
}

/// A single time-slot cell.
class _TimeSlotTile extends StatelessWidget {
  final AppointmentTimeSlot slot;
  final bool isSelected;
  final VoidCallback? onTap;

  const _TimeSlotTile({
    required this.slot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color fill;
    final Color textColor;

    if (isSelected) {
      // Selected — Figma `#314158` fill, white text.
      // The border deliberately stays `#E2E8F0`, unlike the date tile.
      fill = AppColors.navy;
      textColor = AppColors.white;
    } else if (!slot.isAvailable) {
      // Unavailable — Figma `#F8FAFC` fill with a struck-through label.
      fill = AppColors.surfaceSubtle;
      textColor = ChooseAppointmentStyles.unavailableText;
    } else {
      // Available — white fill.
      fill = AppColors.white;
      textColor = ChooseAppointmentStyles.dateAndSlotText;
    }

    return Semantics(
      button: true,
      enabled: slot.isAvailable,
      selected: isSelected,
      label: slot.label,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider, width: 1.2),
          ),
          child: Text(
            slot.label,
            textAlign: TextAlign.center,
            style: ChooseAppointmentStyles.timeSlot.copyWith(
              decoration:
                  slot.isAvailable
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
