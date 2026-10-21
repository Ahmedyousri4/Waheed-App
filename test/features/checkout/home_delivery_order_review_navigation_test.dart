import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waheed/core/managers/cart_manager.dart';
import 'package:waheed/features/checkout/add_address_screen.dart';
import 'package:waheed/features/checkout/checkout_screen.dart';
import 'package:waheed/features/checkout/models/address_model.dart';
import 'package:waheed/features/checkout/order_review_screen.dart';
import 'package:waheed/features/checkout/widgets/address_bottom_sheet.dart';
import 'package:waheed/features/checkout/widgets/checkout_bottom_bar.dart';
import 'package:waheed/features/checkout/widgets/receiving_method_section.dart';

void main() {
  setUp(() {
    CartManager.cartNotifier.value = [];
    CartManager.addToCart({'image': 'suit.svg', 'title': 'بدلة', 'price': 100});
  });

  tearDown(() => CartManager.cartNotifier.value = []);

  testWidgets(
    'valid home-delivery address submits to OrderReviewScreen with its data',
    (tester) async {
      // The existing delivery-method row overflows at narrower widths; use a
      // supported wide viewport so this test isolates the routing contract.
      tester.view.physicalSize = const Size(520, 1200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: CheckoutScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('إضافة عنوان جديد'));
      await tester.pumpAndSettle();
      final sheet = find.byType(AddressBottomSheet);
      await tester.tap(
        find.descendant(of: sheet, matching: find.text('إضافة عنوان جديد')),
      );
      await tester.pumpAndSettle();

      // AddAddressScreen fields are ordered name, area, city, phone, detail.
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), 'Test Customer');
      await tester.enterText(fields.at(1), 'Dokki');
      await tester.enterText(fields.at(2), 'Giza');
      await tester.enterText(fields.at(3), '01012345678');
      await tester.enterText(fields.at(4), '12 Example Street');
      await tester.tap(find.text('حفظ العنوان'));
      await tester.pump(const Duration(milliseconds: 800));
      await tester.pumpAndSettle();

      expect(find.byType(AddAddressScreen), findsNothing);
      expect(find.textContaining('Test Customer'), findsOneWidget);

      await tester.tap(
        find.descendant(
          of: find.byType(CheckoutBottomBar),
          matching: find.text('إتمام الطلب'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(OrderReviewScreen), findsOneWidget);
      final review = tester.widget<OrderReviewScreen>(
        find.byType(OrderReviewScreen),
      );
      expect(review.args.receivingMethod, ReceivingMethod.deliveryToHome);
      final address = review.args.address;
      expect(address, isA<AddressModel>());
      expect(address!.name, 'Test Customer');
      expect(address.area, 'Dokki');
      expect(address.city, 'Giza');
      expect(address.phone, '01012345678');
      expect(address.detailedAddress, '12 Example Street');
    },
  );
}
