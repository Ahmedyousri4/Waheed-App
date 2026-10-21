import 'package:flutter/material.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/booking_confirmation_screen.dart';
import 'package:waheed/features/checkout/data/appointment_availability.dart';
import 'package:waheed/features/checkout/models/branch_model.dart';
import 'package:waheed/features/checkout/utils/choose_appointment_styles.dart';
import 'package:waheed/features/checkout/widgets/appointment_date_strip.dart';
import 'package:waheed/features/checkout/widgets/appointment_time_grid.dart';
import 'package:waheed/features/checkout/widgets/choose_appointment_back_button.dart';

/// اختر الموعد — Choose Appointment screen (Figma node 3526:5940).
///
/// Branch-pickup only. Lets the customer pick a date and a time slot, and
/// shows the branch being collected from.
///
/// The confirmation CTA activates when both a valid date and time slot
/// are selected, navigating to [BookingConfirmationScreen] (node 3526:6123).
/// Incomplete or unavailable selections keep the CTA disabled.
class PickupSchedulingScreen extends StatefulWidget {
  /// Branch the appointment is being booked for.
  final BranchModel branch;

  /// Optional dates list for custom availability or testing.
  /// Falls back to [temporaryAppointmentDates].
  final List<AppointmentDateOption>? dates;

  const PickupSchedulingScreen({super.key, required this.branch, this.dates});

  @override
  State<PickupSchedulingScreen> createState() => _PickupSchedulingScreenState();
}

class _PickupSchedulingScreenState extends State<PickupSchedulingScreen> {
  List<AppointmentDateOption> get _dates =>
      widget.dates ?? temporaryAppointmentDates;

  int? _selectedDateIndex;
  String? _selectedTimeLabel;

  @override
  void initState() {
    super.initState();
    // A date is highlighted on entry if available, but no TIME is ever
    // preselected — product-owner requirement. Derived, not hardcoded.
    final firstAvailableIndex = _dates.indexWhere((date) => date.isAvailable);
    _selectedDateIndex = firstAvailableIndex != -1 ? firstAvailableIndex : null;
  }

  @override
  void didUpdateWidget(covariant PickupSchedulingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dates != oldWidget.dates) {
      if (_selectedDateIndex != null) {
        if (_selectedDateIndex! >= _dates.length ||
            !_dates[_selectedDateIndex!].isAvailable) {
          _selectedDateIndex = null;
          _selectedTimeLabel = null;
        } else {
          final label = _selectedTimeLabel;
          if (label != null &&
              !_dates[_selectedDateIndex!].timeSlots.any(
                (slot) => slot.label == label && slot.isAvailable,
              )) {
            _selectedTimeLabel = null;
          }
        }
      }
    }
  }

  AppointmentDateOption? get _selectedDate {
    final index = _selectedDateIndex;
    if (index == null || index < 0 || index >= _dates.length) return null;
    return _dates[index];
  }

  bool get _isDateValid => _selectedDate?.isAvailable == true;

  /// The retained slot if — and only if — it is still available on the
  /// currently selected date. Returns `null` for a stale selection.
  AppointmentTimeSlot? get _validSelectedSlot {
    final date = _selectedDate;
    if (date == null || !date.isAvailable) return null;
    final label = _selectedTimeLabel;
    if (label == null) return null;
    for (final slot in date.timeSlots) {
      if (slot.label == label && slot.isAvailable) return slot;
    }
    return null;
  }

  /// Drives the CTA. Derived from selection validity of BOTH selections,
  /// never a stored flag.
  bool get _hasValidAppointment => _isDateValid && _validSelectedSlot != null;

  // ── Selection handlers ──────────────────────────────────────────────

  void _onDateSelected(int index) {
    if (index < 0 || index >= _dates.length) return;
    final newDate = _dates[index];
    if (!newDate.isAvailable) return;

    setState(() {
      if (_selectedDateIndex == index) {
        _selectedDateIndex = null;
        _selectedTimeLabel = null;
        return;
      }

      _selectedDateIndex = index;
      // Revalidate the retained time against the new date's slots: clear
      // it when it is no longer available, keep it when it still is.
      final label = _selectedTimeLabel;
      if (label != null &&
          !newDate.timeSlots.any(
            (slot) => slot.label == label && slot.isAvailable,
          )) {
        _selectedTimeLabel = null;
      }
    });
  }

  void _onTimeSelected(String label) {
    if (!_isDateValid) return;
    setState(() {
      if (_selectedTimeLabel == label) {
        _selectedTimeLabel = null;
      } else {
        _selectedTimeLabel = label;
      }
    });
  }

  // ── Figma-specific colours / effects (no exact AppColors token) ─────

  /// Header and footer hairline — Figma `#EAEAEA` (spec §7: not exact
  /// `AppColors.border #ECECEC`; no global token is altered).
  static const Color _hairline = ChooseAppointmentStyles.hairline;

  /// Branch icon tile — Figma `rgba(30,58,138,0.06)`.
  static const Color _branchTileColor = ChooseAppointmentStyles.branchIconTile;

  /// Active CTA fill — Figma pure `#000000` (not `AppColors.black #111111`).
  static const Color _activeCtaFill = ChooseAppointmentStyles.activeCtaFill;

  /// Disabled CTA fallback: Figma exposes no disabled variant, so the
  /// product-required gray state uses the closest shared project tokens.
  static const Color _disabledCtaFill = ChooseAppointmentStyles.disabledCtaFill;
  static const Color _disabledCtaLabel =
      ChooseAppointmentStyles.disabledCtaLabel;

  static const List<BoxShadow> _panelShadow =
      ChooseAppointmentStyles.panelShadow;

  static const List<BoxShadow> _ctaShadow = ChooseAppointmentStyles.ctaShadow;

  // ── Build ───────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateSection(),
                  const SizedBox(height: 16),
                  _buildTimeSection(),
                  const SizedBox(height: 16),
                  _buildBranchCard(),
                ],
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 64,
      shape: const Border(bottom: BorderSide(color: _hairline, width: 1)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ChooseAppointmentBackButton(),
          Text('اختر الموعد', style: ChooseAppointmentStyles.headerTitle),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  /// Icon + title heading, right-aligned for RTL (Figma `3526:5944`).
  ///
  /// Built locally rather than reusing `CheckoutSectionHeader`, whose
  /// 20 px icon / Inter / w800 treatment does not match this node's
  /// 16 px icon / Cairo / SemiBold spec. No shared widget is modified.
  Widget _buildSectionHeader({required String icon, required String title}) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4),
      child: Row(
        children: [
          AppImage(image: icon, height: 16, width: 16),
          const SizedBox(width: 8),
          Text(title, style: ChooseAppointmentStyles.sectionHeading),
        ],
      ),
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(icon: 'calendar.svg', title: 'اختر التاريخ'),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: _panelShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('مايو ٢٠٢٦', style: ChooseAppointmentStyles.monthLabel),
              const SizedBox(height: 12),
              AppointmentDateStrip(
                dates: _dates,
                selectedIndex: _selectedDateIndex,
                onSelect: _onDateSelected,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(icon: 'clock.svg', title: 'اختر الوقت'),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: _panelShadow,
          ),
          child: AppointmentTimeGrid(
            slots:
                (_selectedDate != null && _selectedDate!.isAvailable)
                    ? _selectedDate!.timeSlots
                    : const <AppointmentTimeSlot>[],
            selectedLabel: _validSelectedSlot?.label,
            onSelect: _onTimeSelected,
          ),
        ),
      ],
    );
  }

  Widget _buildBranchCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: _panelShadow,
      ),
      child: Row(
        children: [
          // Icon tile sits on the right in RTL (Figma `3526:6087`).
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: _branchTileColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(
              child: AppImage(
                image: 'store.svg',
                height: 20,
                width: 20,
                color: AppColors.navy,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.branch.name,
                  textAlign: TextAlign.end,
                  style: ChooseAppointmentStyles.branchTitle,
                ),
                const SizedBox(height: 2),
                Text(
                  widget.branch.address,
                  textAlign: TextAlign.end,
                  style: ChooseAppointmentStyles.branchSubtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Actions ─────────────────────────────────────────────────────────

  void _onConfirmAppointment() {
    if (!_hasValidAppointment) return;

    final AppointmentDateOption date = _selectedDate!;
    final AppointmentTimeSlot slot = _validSelectedSlot!;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => BookingConfirmationScreen(
              // Temporary preview order number until backend order creation is integrated
              orderNumber: 'EQ-862334',
              branch: widget.branch,
              appointmentDate:
                  '${date.weekday}، ${date.dayNumber} ${date.month}',
              appointmentTime: slot.label,
            ),
      ),
    );
  }

  // ── Footer ──────────────────────────────────────────────────────────

  /// Fixed bottom action area (Figma `3526:6116`).
  Widget _buildFooter() {
    final bool valid = _hasValidAppointment;
    final String label = valid ? 'تأكيد الموعد' : 'اختر وقتًا للمتابعة';

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: _hairline, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SafeArea(
        top: false,
        child: Semantics(
          button: true,
          enabled: valid,
          label: label,
          excludeSemantics: true,
          child: GestureDetector(
            onTap: valid ? _onConfirmAppointment : null,
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: valid ? _activeCtaFill : _disabledCtaFill,
                borderRadius: BorderRadius.circular(16),
                boxShadow: valid ? _ctaShadow : null,
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: ChooseAppointmentStyles.ctaLabel.copyWith(
                  color: valid ? AppColors.white : _disabledCtaLabel,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
