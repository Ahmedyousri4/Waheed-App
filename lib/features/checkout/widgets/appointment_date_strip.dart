import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/features/checkout/data/appointment_availability.dart';
import 'package:waheed/features/checkout/utils/choose_appointment_styles.dart';

/// Date-strip colors and typography come from the feature-scoped styles.

// ── Figma-specific colours with no exact AppColors token ──────────────
// Spec §7: these are documented local values, not new shared tokens.

/// Height of a single date card (Figma `3526:5955` ≈ 56 × 80).
const double _tileWidth = 56;
const double _tileHeight = 80;

/// Horizontal scrollable date selector (Figma `3526:5954`).
///
/// Laid out RTL by the ambient `Directionality`: index 0 renders at the
/// right edge, so ascending dates progress leftwards exactly as in the
/// design. Dates beyond the panel width scroll horizontally — the Figma
/// node clips them without exposing a gesture, and the product owner
/// approved a scrollable strip.
class AppointmentDateStrip extends StatelessWidget {
  final List<AppointmentDateOption> dates;

  /// Index of the selected date, or `null` when nothing is selected.
  final int? selectedIndex;

  final ValueChanged<int> onSelect;

  const AppointmentDateStrip({
    super.key,
    required this.dates,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _tileHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: dates.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final date = dates[index];
          return _DateTile(
            date: date,
            isSelected: index == selectedIndex,
            // Unavailable dates are non-interactive.
            onTap: date.isAvailable ? () => onSelect(index) : null,
          );
        },
      ),
    );
  }
}

/// A single 56 × 80 date card.
class _DateTile extends StatelessWidget {
  final AppointmentDateOption date;
  final bool isSelected;
  final VoidCallback? onTap;

  const _DateTile({
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color fill;
    final Color border;
    final Color textColor;

    if (isSelected) {
      // Selected — Figma `#314158` fill and border, white text.
      fill = AppColors.navy;
      border = AppColors.navy;
      textColor = AppColors.white;
    } else if (!date.isAvailable) {
      // Unavailable — Figma `#F8FAFC` fill, `#E2E8F0` border, 50% opacity.
      fill = AppColors.surfaceSubtle;
      border = AppColors.divider;
      textColor = ChooseAppointmentStyles.unavailableText;
    } else {
      // Available — white fill, `#E2E8F0` border.
      fill = AppColors.white;
      border = AppColors.divider;
      textColor = ChooseAppointmentStyles.dateAndSlotText;
    }

    // Figma applies 50% opacity to the whole unavailable button.
    final Widget card = Semantics(
      button: true,
      enabled: date.isAvailable,
      selected: isSelected,
      label: '${date.weekday} ${date.dayNumber} ${date.month}',
      excludeSemantics: true,
      child: Container(
        width: _tileWidth,
        height: _tileHeight,
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, width: 1.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.weekday,
              textAlign: TextAlign.center,
              style: ChooseAppointmentStyles.dateWeekday.copyWith(
                // Figma renders weekday/month at 70% opacity.
                color: textColor.withValues(alpha: 0.7),
              ),
            ),
            Text(
              date.dayNumber,
              textAlign: TextAlign.center,
              style: ChooseAppointmentStyles.dateNumber.copyWith(
                color: textColor,
              ),
            ),
            Text(
              date.month,
              textAlign: TextAlign.center,
              style: ChooseAppointmentStyles.dateMonth.copyWith(
                color: textColor.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );

    // `GestureDetector` with a null callback still reports the semantics
    // above, but adds no tap target — unavailable dates cannot be chosen.
    return GestureDetector(onTap: onTap, child: card);
  }
}
