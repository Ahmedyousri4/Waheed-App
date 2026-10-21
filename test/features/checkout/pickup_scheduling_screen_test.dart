// Focused widget tests for the Choose Appointment screen
// (Figma node 3526:5940) and its branch-pickup integration.
//
// Covers the CTA validity contract, date/time selection, date-change
// revalidation, the inert confirmation button, and the home-delivery
// regression path.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waheed/app/theme/app_colors.dart';
import 'package:waheed/core/managers/cart_manager.dart';
import 'package:waheed/features/checkout/booking_confirmation_screen.dart';
import 'package:waheed/features/checkout/checkout_screen.dart';
import 'package:waheed/features/checkout/data/appointment_availability.dart';
import 'package:waheed/features/checkout/models/branch_model.dart';
import 'package:waheed/features/checkout/order_review_screen.dart';
import 'package:waheed/features/checkout/pickup_scheduling_screen.dart';
import 'package:waheed/features/checkout/widgets/receiving_method_section.dart';
import 'package:waheed/features/checkout/widgets/choose_appointment_back_button.dart';
import 'package:waheed/features/checkout/success_screen.dart';

// ── CTA labels ────────────────────────────────────────────────────────
const String _disabledLabel = 'اختر وقتًا للمتابعة';
const String _enabledLabel = 'تأكيد الموعد';

/// Figma node target viewport.
const Size _targetSize = Size(402, 905);

Future<void> _pumpAppointmentScreen(
  WidgetTester tester, {
  BranchModel branch = BranchModel.defaultBranch,
  List<AppointmentDateOption>? dates,
}) async {
  tester.view.physicalSize = _targetSize;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      // Explicit RTL — the app default locale is Arabic.
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: PickupSchedulingScreen(branch: branch, dates: dates),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Resolves the decorated container directly wrapping [label]'s text.
BoxDecoration _decorationOf(WidgetTester tester, String label) {
  final containers = tester.widgetList<Container>(
    find.ancestor(of: find.text(label), matching: find.byType(Container)),
  );
  final container = containers.firstWhere(
    (c) =>
        c.decoration is BoxDecoration &&
        (c.decoration as BoxDecoration).color != null,
    orElse: () => throw StateError('No decorated container for "$label"'),
  );
  return container.decoration! as BoxDecoration;
}

/// The bottom confirmation CTA.
BoxDecoration _ctaDecoration(WidgetTester tester) {
  final label =
      find.text(_enabledLabel).evaluate().isNotEmpty
          ? _enabledLabel
          : _disabledLabel;
  return _decorationOf(tester, label);
}

/// Asserts that [finder]'s semantics node is explicitly marked disabled.
void _expectDisabled(WidgetTester tester, Finder finder, String reason) {
  final semantics = tester.getSemantics(finder);
  expect(
    semantics.hasFlag(SemanticsFlag.hasEnabledState),
    isTrue,
    reason: '$reason — the enabled state must be published',
  );
  expect(
    semantics.hasFlag(SemanticsFlag.isEnabled),
    isFalse,
    reason: '$reason — must be announced as disabled',
  );
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  group('Initial state', () {
    testWidgets('no appointment time is selected on entry', (tester) async {
      await _pumpAppointmentScreen(tester);

      // A date is highlighted, but every slot renders unselected (white).
      expect(find.byType(PickupSchedulingScreen), findsOneWidget);
      for (final slot in _slotsForFirstAvailableDate) {
        if (!slot.isAvailable) continue;
        expect(
          _decorationOf(tester, slot.label).color,
          AppColors.white,
          reason: '"${slot.label}" must start unselected',
        );
      }
    });

    testWidgets('initial CTA label is اختر وقتًا للمتابعة', (tester) async {
      await _pumpAppointmentScreen(tester);

      expect(find.text(_disabledLabel), findsOneWidget);
      expect(find.text(_enabledLabel), findsNothing);
    });

    testWidgets('initial CTA uses the disabled-looking style', (tester) async {
      await _pumpAppointmentScreen(tester);

      final decoration = _ctaDecoration(tester);
      expect(decoration.color, AppColors.divider);
      expect(decoration.boxShadow, isNull);
    });

    testWidgets('initial CTA cannot be activated', (tester) async {
      await _pumpAppointmentScreen(tester);

      await tester.tap(find.text(_disabledLabel));
      await tester.pumpAndSettle();

      // Still on the same screen, still disabled, nothing pushed.
      expect(find.byType(PickupSchedulingScreen), findsOneWidget);
      expect(find.text(_disabledLabel), findsOneWidget);
      expect(find.byType(OrderReviewScreen), findsNothing);
      expect(find.byType(SuccessScreen), findsNothing);
    });

    testWidgets('unavailable dates are marked non-interactive', (tester) async {
      await _pumpAppointmentScreen(tester);

      // 17, 18 and 19 are the visibly unavailable dates in the fixtures.
      for (final day in ['١٧', '١٨', '١٩']) {
        _expectDisabled(tester, find.text(day), 'Unavailable date "$day"');
      }
    });
  });

  group('Selecting a time', () {
    testWidgets('selecting a valid time marks it and enables the CTA', (
      tester,
    ) async {
      await _pumpAppointmentScreen(tester);

      await _tap(tester, find.text('٠٣:٠٠ م'));

      // Selected slot takes the dark navy treatment.
      expect(_decorationOf(tester, '٠٣:٠٠ م').color, AppColors.navy);
      // CTA flips to the dark enabled style with the new label.
      expect(find.text(_enabledLabel), findsOneWidget);
      expect(find.text(_disabledLabel), findsNothing);
      expect(_ctaDecoration(tester).color, Colors.black);
      expect(_ctaDecoration(tester).boxShadow, isNotNull);
    });

    testWidgets('selecting another time moves the selection', (tester) async {
      await _pumpAppointmentScreen(tester);

      await _tap(tester, find.text('٠٣:٠٠ م'));
      await _tap(tester, find.text('٠٤:٣٠ م'));

      // Exactly one slot selected.
      expect(_decorationOf(tester, '٠٤:٣٠ م').color, AppColors.navy);
      expect(_decorationOf(tester, '٠٣:٠٠ م').color, AppColors.white);
    });

    testWidgets('unavailable slots cannot be selected', (tester) async {
      await _pumpAppointmentScreen(tester);

      // ١٢:٠٠ م is unavailable on the initially selected date.
      _expectDisabled(tester, find.text('١٢:٠٠ م'), 'Unavailable slot');

      await _tap(tester, find.text('١٢:٠٠ م'));

      // Selection state is unchanged and the CTA stays disabled.
      expect(_decorationOf(tester, '١٢:٠٠ م').color, AppColors.surfaceSubtle);
      expect(find.text(_disabledLabel), findsOneWidget);
      expect(find.text(_enabledLabel), findsNothing);
    });
  });

  group('Changing the date', () {
    testWidgets('clears a time that is unavailable on the new date', (
      tester,
    ) async {
      await _pumpAppointmentScreen(tester);

      await _tap(tester, find.text('٠٣:٠٠ م'));
      expect(find.text(_enabledLabel), findsOneWidget);

      // 21 May uses a slot set without ٠٣:٠٠ م.
      await _tap(tester, find.text('٢١'));

      expect(find.text(_disabledLabel), findsOneWidget);
      expect(find.text(_enabledLabel), findsNothing);
      expect(find.text('٠٣:٠٠ م'), findsNothing);
      expect(_ctaDecoration(tester).color, AppColors.divider);
    });

    testWidgets('keeps a time that is still available on the new date', (
      tester,
    ) async {
      await _pumpAppointmentScreen(tester);

      await _tap(tester, find.text('٠٣:٠٠ م'));

      // 22 May also offers ٠٣:٠٠ م.
      await _tap(tester, find.text('٢٢'));

      expect(find.text(_enabledLabel), findsOneWidget);
      expect(_decorationOf(tester, '٠٣:٠٠ م').color, AppColors.navy);
    });
  });

  group('Confirmation button', () {
    testWidgets(
      'navigates to BookingConfirmationScreen when appointment is valid',
      (tester) async {
        await _pumpAppointmentScreen(tester);

        await _tap(tester, find.text('٠٣:٠٠ م'));
        expect(find.text(_enabledLabel), findsOneWidget);

        await tester.tap(find.text(_enabledLabel));
        await tester.pumpAndSettle();

        expect(find.byType(BookingConfirmationScreen), findsOneWidget);
      },
    );

    testWidgets('has gesture handler wired to it when valid', (tester) async {
      await _pumpAppointmentScreen(tester);
      await _tap(tester, find.text('٠٣:٠٠ م'));

      final gestureDetectors = tester.widgetList<GestureDetector>(
        find.ancestor(
          of: find.text(_enabledLabel),
          matching: find.byType(GestureDetector),
        ),
      );
      expect(
        gestureDetectors.where((g) => g.onTap != null),
        isNotEmpty,
        reason: 'The confirmation CTA must be tappable when valid',
      );
    });

    testWidgets(
      'is announced as enabled when valid and disabled when invalid',
      (tester) async {
        await _pumpAppointmentScreen(tester);

        _expectDisabled(tester, find.text(_disabledLabel), 'Initial CTA');

        await _tap(tester, find.text('٠٣:٠٠ م'));

        final semantics = tester.getSemantics(find.text(_enabledLabel));
        expect(semantics.hasFlag(SemanticsFlag.isEnabled), isTrue);
      },
    );
  });

  group('CTA validity matrix and edge cases', () {
    testWidgets(
      'Case 1: No date and no time produces disabled CTA with اختر وقتًا للمتابعة',
      (tester) async {
        await _pumpAppointmentScreen(tester, dates: const []);

        expect(find.text(_disabledLabel), findsOneWidget);
        expect(find.text(_enabledLabel), findsNothing);
        expect(_ctaDecoration(tester).color, AppColors.divider);
        expect(_ctaDecoration(tester).boxShadow, isNull);
      },
    );

    testWidgets(
      'Case 1b: Only unavailable dates in list produces disabled CTA with no date selected',
      (tester) async {
        await _pumpAppointmentScreen(
          tester,
          dates: const [
            AppointmentDateOption(
              dayNumber: '١٧',
              weekday: 'الأحد',
              month: 'مايو',
              isAvailable: false,
              timeSlots: [],
            ),
          ],
        );

        expect(find.text(_disabledLabel), findsOneWidget);
        expect(find.text(_enabledLabel), findsNothing);
        expect(_ctaDecoration(tester).color, AppColors.divider);
      },
    );

    testWidgets(
      'Case 2: Valid date but no time produces disabled CTA with اختر وقتًا للمتابعة',
      (tester) async {
        await _pumpAppointmentScreen(tester);

        // Wednesday 20 May is valid and selected, but no time is selected.
        expect(find.text(_disabledLabel), findsOneWidget);
        expect(find.text(_enabledLabel), findsNothing);
        expect(_ctaDecoration(tester).color, AppColors.divider);
      },
    );

    testWidgets(
      'Case 3: Valid date and available selected time shows active تأكيد الموعد and navigates to BookingConfirmationScreen',
      (tester) async {
        await _pumpAppointmentScreen(tester);

        await _tap(tester, find.text('٠٣:٠٠ م'));

        expect(find.text(_enabledLabel), findsOneWidget);
        expect(find.text(_disabledLabel), findsNothing);
        expect(_ctaDecoration(tester).color, Colors.black);
        expect(_ctaDecoration(tester).boxShadow, isNotNull);

        // Active CTA navigates to BookingConfirmationScreen
        await tester.tap(find.text(_enabledLabel));
        await tester.pumpAndSettle();
        expect(find.byType(BookingConfirmationScreen), findsOneWidget);
      },
    );

    testWidgets(
      'Case 4: Date changes to one where selected time is unavailable resets CTA to اختر وقتًا للمتابعة',
      (tester) async {
        await _pumpAppointmentScreen(tester);

        await _tap(tester, find.text('٠٣:٠٠ م'));
        expect(find.text(_enabledLabel), findsOneWidget);

        // 21 May does not offer ٠٣:٠٠ م.
        await _tap(tester, find.text('٢١'));

        expect(find.text(_disabledLabel), findsOneWidget);
        expect(find.text(_enabledLabel), findsNothing);
        expect(_ctaDecoration(tester).color, AppColors.divider);
      },
    );

    testWidgets(
      'Case 5: Tapping currently selected date clears date and time selection, returning CTA to disabled state',
      (tester) async {
        await _pumpAppointmentScreen(tester);
        await _tap(tester, find.text('٠٣:٠٠ م'));
        expect(find.text(_enabledLabel), findsOneWidget);

        // Re-tap the selected date '٢٠' -> toggles off and clears date and time selection.
        await _tap(tester, find.text('٢٠'));

        expect(find.text(_disabledLabel), findsOneWidget);
        expect(find.text(_enabledLabel), findsNothing);
        expect(_ctaDecoration(tester).color, AppColors.divider);

        // Tapping '٢٠' again re-selects it with no time selected.
        await _tap(tester, find.text('٢٠'));
        expect(find.text(_disabledLabel), findsOneWidget);
        expect(find.text(_enabledLabel), findsNothing);
      },
    );

    testWidgets(
      'Case 5b: Tapping currently selected time slot clears time selection, returning CTA to disabled state',
      (tester) async {
        await _pumpAppointmentScreen(tester);
        await _tap(tester, find.text('٠٣:٠٠ م'));
        expect(find.text(_enabledLabel), findsOneWidget);

        // Re-tap the selected time slot '٠٣:٠٠ م' -> toggles off and clears time selection.
        await _tap(tester, find.text('٠٣:٠٠ م'));

        expect(find.text(_disabledLabel), findsOneWidget);
        expect(find.text(_enabledLabel), findsNothing);
        expect(_ctaDecoration(tester).color, AppColors.divider);
        expect(_decorationOf(tester, '٠٣:٠٠ م').color, AppColors.white);

        // Tapping '٠٣:٠٠ م' again re-selects it and enables CTA.
        await _tap(tester, find.text('٠٣:٠٠ م'));
        expect(find.text(_enabledLabel), findsOneWidget);
        expect(_ctaDecoration(tester).color, Colors.black);
      },
    );

    testWidgets('Case 6: Unavailable time slot cannot enable confirmation', (
      tester,
    ) async {
      await _pumpAppointmentScreen(tester);

      // ١٢:٠٠ م is marked unavailable on the first available date.
      await _tap(tester, find.text('١٢:٠٠ م'));

      expect(find.text(_disabledLabel), findsOneWidget);
      expect(find.text(_enabledLabel), findsNothing);
      expect(_ctaDecoration(tester).color, AppColors.divider);
    });
  });

  group('Branch card', () {
    testWidgets('shows the supplied branch, not a hardcoded example', (
      tester,
    ) async {
      const branch = BranchModel(
        name: 'فرع الاختبار',
        address: 'عنوان الاختبار',
      );

      await _pumpAppointmentScreen(tester, branch: branch);

      expect(find.text('فرع الاختبار'), findsOneWidget);
      expect(find.text('عنوان الاختبار'), findsOneWidget);
      // The Figma example branch must not be hardcoded into the screen.
      expect(find.textContaining('الفرع الرئيسي'), findsNothing);
    });

    testWidgets('renders the default branch when that is what is supplied', (
      tester,
    ) async {
      await _pumpAppointmentScreen(tester);

      expect(find.text(BranchModel.defaultBranch.name), findsOneWidget);
      expect(find.text(BranchModel.defaultBranch.address), findsOneWidget);
    });
  });

  group('Checkout integration', () {
    setUp(() {
      CartManager.cartNotifier.value = [
        {'image': 'suit.svg', 'title': 'بدلة', 'price': 100, 'quantity': 1},
      ];
    });

    tearDown(() => CartManager.cartNotifier.value = []);

    // ⚠️ PRE-EXISTING LAYOUT DEFECT (out of scope for this task) ────────
    // `_DeliveryMethodCard`'s title+badge Row in
    // lib/features/checkout/widgets/delivery_method_section.dart:119
    // overflows by 36 px at the 402 px Figma target width — and at every
    // narrower phone width — because the "التوصيل السريع" title plus the
    // "جديد" badge exceed the space left after the radio button.
    //
    // That file is untouched by this change (verified: byte-identical to
    // HEAD) and belongs to the home-delivery flow, which this task is
    // forbidden to modify. The overflow aborts layout, which would mask
    // the routing behaviour under test.
    //
    // These tests therefore run at a width where the EXISTING checkout
    // screen lays out cleanly, so they assert routing only. The defect
    // itself is reported separately for the product owner.
    Future<void> pumpCheckout(WidgetTester tester) async {
      tester.view.physicalSize = const Size(520, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: const CheckoutScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    // NOTE: these tests assert the routing boundary only. Driving the
    // delivery path all the way to OrderReviewScreen additionally requires
    // completing the unrelated "add address" form, which is pre-existing
    // delivery-flow behaviour and out of scope for this task.
    testWidgets('home delivery never routes to the appointment screen', (
      tester,
    ) async {
      await pumpCheckout(tester);

      // Default receiving method is home delivery, with no address chosen.
      await _tap(tester, find.widgetWithText(ElevatedButton, 'إتمام الطلب'));

      // Existing address validation still gates navigation, and the
      // pickup screen is never entered from the delivery path.
      expect(find.text('يرجى إضافة عنوان التوصيل'), findsOneWidget);
      expect(find.byType(CheckoutScreen), findsOneWidget);
      expect(find.byType(PickupSchedulingScreen), findsNothing);
      expect(find.byType(OrderReviewScreen), findsNothing);
    });

    testWidgets('selecting pickup does not navigate on its own', (
      tester,
    ) async {
      await pumpCheckout(tester);

      await _tap(tester, find.text('استلام من الفرع'));

      // Still on checkout — the method toggle only changes inline details.
      expect(find.byType(CheckoutScreen), findsOneWidget);
      expect(find.byType(PickupSchedulingScreen), findsNothing);
      expect(find.byType(OrderReviewScreen), findsNothing);
    });

    testWidgets('pickup opens the Choose Appointment screen', (tester) async {
      await pumpCheckout(tester);

      await _tap(tester, find.text('استلام من الفرع'));
      await _tap(tester, find.widgetWithText(ElevatedButton, 'إتمام الطلب'));

      expect(find.byType(PickupSchedulingScreen), findsOneWidget);
      expect(find.byType(OrderReviewScreen), findsNothing);
      // The current branch is handed through.
      expect(find.text(BranchModel.defaultBranch.name), findsOneWidget);
    });

    testWidgets('returning from pickup restores the delivery path', (
      tester,
    ) async {
      await pumpCheckout(tester);

      // Enter the appointment screen, then come back.
      await _tap(tester, find.text('استلام من الفرع'));
      await _tap(tester, find.widgetWithText(ElevatedButton, 'إتمام الطلب'));
      expect(find.byType(PickupSchedulingScreen), findsOneWidget);

      await _tap(tester, find.byType(ChooseAppointmentBackButton));
      expect(find.byType(CheckoutScreen), findsOneWidget);

      // Switch back to home delivery and confirm the delivery path is
      // intact: pickup is not opened and delivery validation still runs.
      await _tap(tester, find.text('توصيل للمنزل'));
      await _tap(tester, find.widgetWithText(ElevatedButton, 'إتمام الطلب'));

      expect(find.text('يرجى إضافة عنوان التوصيل'), findsOneWidget);
      expect(find.byType(PickupSchedulingScreen), findsNothing);
    });

    testWidgets('ReceivingMethod enum is unchanged', (tester) async {
      // Guards against an accidental rename breaking the home-delivery flow.
      expect(ReceivingMethod.values, [
        ReceivingMethod.pickupFromBranch,
        ReceivingMethod.deliveryToHome,
      ]);
    });
  });
}

/// Slots of the first available fixture date, for initial-state assertions.
List<AppointmentTimeSlot> get _slotsForFirstAvailableDate =>
    temporaryAppointmentDates.firstWhere((date) => date.isAvailable).timeSlots;
