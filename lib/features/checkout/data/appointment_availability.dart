/// TEMPORARY appointment availability fixtures.
///
/// ⚠️  THESE ARE NOT REAL BRANCH APPOINTMENTS. ⚠️
///
/// No live appointment-availability source exists in this project today
/// (verified: no appointment model, API, repository, or persistence layer
/// is present). These in-memory constants exist **only** so the Choose
/// Appointment UI (Figma node 3526:5940) can be rendered and widget-tested.
///
/// They must NOT be presented to the user as live availability, and they
/// must be replaced — not extended — once the product owner identifies the
/// real availability source and its loading/error/timezone rules.
///
/// See `.ai/state/figma-choose-appointment-3526-5940-spec.md` §4 and §9.2.
library;

/// A single bookable time slot within a date.
///
/// Pure display data. No timezone, expiry, or scheduling rule is modelled
/// because none is specified.
class AppointmentTimeSlot {
  /// Pre-formatted Arabic-Indic display label, e.g. `٠٣:٠٠ م`.
  ///
  /// Stored pre-formatted because no locale formatting algorithm is
  /// defined for this flow; see spec §3.
  final String label;

  /// Whether the slot may be selected. Unavailable slots render disabled.
  final bool isAvailable;

  const AppointmentTimeSlot({required this.label, this.isAvailable = true});
}

/// A bookable date with its own set of time slots.
class AppointmentDateOption {
  /// Pre-formatted Arabic-Indic day of month, e.g. `٢٠`.
  final String dayNumber;

  /// Arabic weekday name, e.g. `الأربعاء`.
  final String weekday;

  /// Arabic month name, e.g. `مايو`.
  final String month;

  /// Whether the date may be selected (some dates are visibly unavailable).
  final bool isAvailable;

  /// Slots available on **this** date. Availability is per-date, which is
  /// what makes a retained time selection invalid after a date change.
  final List<AppointmentTimeSlot> timeSlots;

  const AppointmentDateOption({
    required this.dayNumber,
    required this.weekday,
    required this.month,
    required this.isAvailable,
    required this.timeSlots,
  });
}

// ── Slot sets ─────────────────────────────────────────────────────────
// Listed in RTL reading order (chronological), matching the Figma grid:
// the first entry renders at the right of each row.

/// The exact 3×3 grid captured in Figma node 3526:5940.
/// `١٢:٠٠ م` and `٠٦:٠٠ م` are shown visually unavailable in the design.
const List<AppointmentTimeSlot> _slotsA = [
  AppointmentTimeSlot(label: '١٠:٣٠ ص'),
  AppointmentTimeSlot(label: '١١:٠٠ ص'),
  AppointmentTimeSlot(label: '١٢:٠٠ م', isAvailable: false),
  AppointmentTimeSlot(label: '٠١:٣٠ م'),
  AppointmentTimeSlot(label: '٠٣:٠٠ م'),
  AppointmentTimeSlot(label: '٠٤:٣٠ م'),
  AppointmentTimeSlot(label: '٠٦:٠٠ م', isAvailable: false),
  AppointmentTimeSlot(label: '٠٧:٣٠ م'),
  AppointmentTimeSlot(label: '٠٩:٠٠ م'),
];

/// Deliberately omits `٠٣:٠٠ م`, so a selection retained from [_slotsA]
/// must be cleared when the customer moves to this date.
const List<AppointmentTimeSlot> _slotsB = [
  AppointmentTimeSlot(label: '١١:٠٠ ص'),
  AppointmentTimeSlot(label: '١٢:٣٠ م'),
  AppointmentTimeSlot(label: '٠٢:٠٠ م'),
  AppointmentTimeSlot(label: '٠٤:٣٠ م'),
  AppointmentTimeSlot(label: '٠٦:٠٠ م'),
  AppointmentTimeSlot(label: '٠٨:٠٠ م'),
];

/// Retains `٠٣:٠٠ م`, so a selection made on a [_slotsA] date survives a
/// move to this date.
const List<AppointmentTimeSlot> _slotsC = [
  AppointmentTimeSlot(label: '١٠:٣٠ ص'),
  AppointmentTimeSlot(label: '٠١:٣٠ م'),
  AppointmentTimeSlot(label: '٠٣:٠٠ م'),
  AppointmentTimeSlot(label: '٠٥:٠٠ م'),
  AppointmentTimeSlot(label: '٠٧:٣٠ م'),
];

// ── Dates ─────────────────────────────────────────────────────────────
// 17–30 May, mirroring the date range present in the Figma node. 17–19 are
// visibly unavailable in the design; no reason is given, and none is invented.

/// TEMPORARY sample dates — not live branch availability.
const List<AppointmentDateOption> temporaryAppointmentDates = [
  AppointmentDateOption(
    dayNumber: '١٧',
    weekday: 'الأحد',
    month: 'مايو',
    isAvailable: false,
    timeSlots: [],
  ),
  AppointmentDateOption(
    dayNumber: '١٨',
    weekday: 'الاثنين',
    month: 'مايو',
    isAvailable: false,
    timeSlots: [],
  ),
  AppointmentDateOption(
    dayNumber: '١٩',
    weekday: 'الثلاثاء',
    month: 'مايو',
    isAvailable: false,
    timeSlots: [],
  ),
  AppointmentDateOption(
    dayNumber: '٢٠',
    weekday: 'الأربعاء',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsA,
  ),
  AppointmentDateOption(
    dayNumber: '٢١',
    weekday: 'الخميس',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsB,
  ),
  AppointmentDateOption(
    dayNumber: '٢٢',
    weekday: 'الجمعة',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsC,
  ),
  AppointmentDateOption(
    dayNumber: '٢٣',
    weekday: 'السبت',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsA,
  ),
  AppointmentDateOption(
    dayNumber: '٢٤',
    weekday: 'الأحد',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsB,
  ),
  AppointmentDateOption(
    dayNumber: '٢٥',
    weekday: 'الاثنين',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsA,
  ),
  AppointmentDateOption(
    dayNumber: '٢٦',
    weekday: 'الثلاثاء',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsC,
  ),
  AppointmentDateOption(
    dayNumber: '٢٧',
    weekday: 'الأربعاء',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsA,
  ),
  AppointmentDateOption(
    dayNumber: '٢٨',
    weekday: 'الخميس',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsB,
  ),
  AppointmentDateOption(
    dayNumber: '٢٩',
    weekday: 'الجمعة',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsC,
  ),
  AppointmentDateOption(
    dayNumber: '٣٠',
    weekday: 'السبت',
    month: 'مايو',
    isAvailable: true,
    timeSlots: _slotsA,
  ),
];
