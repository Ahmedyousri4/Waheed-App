import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/booking_confirmation_screen.dart';
import 'package:waheed/features/checkout/models/branch_model.dart';
import 'package:waheed/features/checkout/pickup_scheduling_screen.dart';
import 'package:waheed/features/home/home_screen.dart';

const Size _targetSize = Size(402, 905);

const BranchModel _testBranch = BranchModel(
  name: 'الفرع الرئيسي – ميت غمر',
  address: 'ميت غمر، شارع المعاهده بجوار كلية التربية النوعية',
);

Future<void> _pumpBookingConfirmationScreen(
  WidgetTester tester, {
  String orderNumber = 'EQ-862334',
  BranchModel branch = _testBranch,
  String appointmentDate = 'الأربعاء، ٢٠ مايو',
  String appointmentTime = '١١:٠٠ ص',
  String tailoringStatus = 'قيد التحضير',
  String tailoringSubline = 'جاهز خلال ٣ أيام',
  VoidCallback? onReturnHome,
}) async {
  tester.view.physicalSize = _targetSize;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: BookingConfirmationScreen(
          orderNumber: orderNumber,
          branch: branch,
          appointmentDate: appointmentDate,
          appointmentTime: appointmentTime,
          tailoringStatus: tailoringStatus,
          tailoringSubline: tailoringSubline,
          onReturnHome: onReturnHome,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BookingConfirmationScreen UI rendering', () {
    testWidgets('renders all screen sections and labels', (tester) async {
      await _pumpBookingConfirmationScreen(tester);

      expect(find.text('تم تأكيد الحجز'), findsOneWidget);
      expect(
        find.text('استلم بدلتك من الفرع في الموعد المحدد'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
      expect(find.text('رقم الطلب'), findsOneWidget);
      expect(find.text('EQ-862334'), findsOneWidget);
      expect(find.text(' نسخ'), findsOneWidget);
      expect(find.text('اعرض هذا الرمز في الفرع للاستلام'), findsOneWidget);
      expect(find.text('فرع الاستلام'), findsOneWidget);
      expect(find.text(_testBranch.name), findsOneWidget);
      expect(find.text(_testBranch.address), findsOneWidget);
      expect(find.text('موعد الاستلام'), findsOneWidget);
      expect(find.text('الأربعاء، ٢٠ مايو'), findsOneWidget);
      expect(find.text('١١:٠٠ ص'), findsOneWidget);
      expect(find.text('حالة التفصيل'), findsOneWidget);
      expect(find.text('قيد التحضير'), findsOneWidget);
      expect(find.text('جاهز خلال ٣ أيام'), findsOneWidget);
      expect(find.text('تتبع الطلب'), findsOneWidget);
      expect(find.text('الرئيسية'), findsOneWidget);
    });
  });

  group('Physical RTL layout matching Figma', () {
    testWidgets('detail row icons are physically on left, text on right', (
      tester,
    ) async {
      await _pumpBookingConfirmationScreen(tester);

      // Branch row
      final storeIcon = tester.getTopLeft(
        find.byWidgetPredicate((w) => w is AppImage && w.image == 'store.svg'),
      );
      final branchText = tester.getTopLeft(find.text('فرع الاستلام'));
      expect(storeIcon.dx, lessThan(branchText.dx));

      // Pickup time row
      final calIcon = tester.getTopLeft(
        find.byWidgetPredicate(
          (w) => w is AppImage && w.image == 'calendar.svg',
        ),
      );
      final timeText = tester.getTopLeft(find.text('موعد الاستلام'));
      expect(calIcon.dx, lessThan(timeText.dx));

      // Tailoring status row
      final scissorIcon = tester.getTopLeft(
        find.byWidgetPredicate(
          (w) => w is AppImage && w.image == 'scissors.svg',
        ),
      );
      final statusText = tester.getTopLeft(find.text('حالة التفصيل'));
      expect(scissorIcon.dx, lessThan(statusText.dx));
    });

    testWidgets('copy action is on physical left, order details on right', (
      tester,
    ) async {
      await _pumpBookingConfirmationScreen(tester);

      final copyPos = tester.getTopLeft(find.text(' نسخ'));
      final orderLabelPos = tester.getTopLeft(find.text('رقم الطلب'));
      final orderNumPos = tester.getTopLeft(find.text('EQ-862334'));

      expect(copyPos.dx, lessThan(orderLabelPos.dx));
      expect(copyPos.dx, lessThan(orderNumPos.dx));
    });

    testWidgets('footer buttons: tracking on left, return home on right', (
      tester,
    ) async {
      await _pumpBookingConfirmationScreen(tester);

      final trackPos = tester.getCenter(find.text('تتبع الطلب'));
      final homePos = tester.getCenter(find.text('الرئيسية'));
      expect(trackPos.dx, lessThan(homePos.dx));

      final homeIcon = tester.getCenter(
        find.byWidgetPredicate((w) => w is AppImage && w.image == 'home.svg'),
      );
      expect(homePos.dx, lessThan(homeIcon.dx));
    });

    testWidgets(
      'QR caption: miniature icon on left, instruction text on right',
      (tester) async {
        await _pumpBookingConfirmationScreen(tester);

        final qrIcon = tester.getCenter(
          find.byWidgetPredicate(
            (w) => w is AppImage && w.image == 'qrcode.svg',
          ),
        );
        final captionText = tester.getCenter(
          find.text('اعرض هذا الرمز في الفرع للاستلام'),
        );
        expect(qrIcon.dx, lessThan(captionText.dx));
      },
    );
  });

  group('Interactive behaviors', () {
    testWidgets(
      'copy button copies order number to clipboard and shows feedback',
      (tester) async {
        final List<MethodCall> log = <MethodCall>[];
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          (MethodCall methodCall) async {
            log.add(methodCall);
            return null;
          },
        );

        await _pumpBookingConfirmationScreen(tester, orderNumber: 'EQ-123456');

        await tester.tap(find.text(' نسخ'));
        await tester.pumpAndSettle();

        expect(
          log.any(
            (call) =>
                call.method == 'Clipboard.setData' &&
                call.arguments['text'] == 'EQ-123456',
          ),
          isTrue,
        );
        expect(find.text('تم نسخ رقم الطلب'), findsOneWidget);
      },
    );

    testWidgets('track order button is inert and does not navigate', (
      tester,
    ) async {
      await _pumpBookingConfirmationScreen(tester);

      await tester.tap(find.text('تتبع الطلب'));
      await tester.pumpAndSettle();

      expect(find.byType(BookingConfirmationScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('home button invokes onReturnHome callback', (tester) async {
      bool returnedHome = false;
      await _pumpBookingConfirmationScreen(
        tester,
        onReturnHome: () => returnedHome = true,
      );

      await tester.tap(find.text('الرئيسية'));
      await tester.pumpAndSettle();

      expect(returnedHome, isTrue);
    });
  });

  group('PickupSchedulingScreen navigation to BookingConfirmationScreen', () {
    testWidgets('valid selection enables CTA and navigates to confirmation', (
      tester,
    ) async {
      tester.view.physicalSize = _targetSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PickupSchedulingScreen(branch: _testBranch),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('٠٣:٠٠ م'));
      await tester.pumpAndSettle();
      expect(find.text('تأكيد الموعد'), findsOneWidget);

      await tester.tap(find.text('تأكيد الموعد'));
      await tester.pumpAndSettle();

      expect(find.byType(BookingConfirmationScreen), findsOneWidget);
      expect(find.text('تم تأكيد الحجز'), findsOneWidget);
      expect(find.text('الأربعاء، ٢٠ مايو'), findsOneWidget);
      expect(find.text('٠٣:٠٠ م'), findsOneWidget);
    });

    testWidgets('missing or toggled-off selection prevents navigation', (
      tester,
    ) async {
      tester.view.physicalSize = _targetSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: PickupSchedulingScreen(branch: _testBranch),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('اختر وقتًا للمتابعة'), findsOneWidget);
      await tester.tap(find.text('اختر وقتًا للمتابعة'));
      await tester.pumpAndSettle();
      expect(find.byType(BookingConfirmationScreen), findsNothing);

      // Select then toggle off
      await tester.tap(find.text('٠٣:٠٠ م'));
      await tester.pumpAndSettle();
      expect(find.text('تأكيد الموعد'), findsOneWidget);

      await tester.tap(find.text('٠٣:٠٠ م'));
      await tester.pumpAndSettle();
      expect(find.text('اختر وقتًا للمتابعة'), findsOneWidget);

      await tester.tap(find.text('اختر وقتًا للمتابعة'));
      await tester.pumpAndSettle();
      expect(find.byType(BookingConfirmationScreen), findsNothing);
    });
  });
}
