import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/checkout/models/branch_model.dart';
import 'package:waheed/features/checkout/pickup_scheduling_screen.dart';
import 'package:waheed/features/checkout/widgets/choose_appointment_back_button.dart';

void main() {
  testWidgets('Choose Appointment back control uses the Figma dimensions', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: PickupSchedulingScreen(branch: BranchModel.defaultBranch),
        ),
      ),
    );

    final backButton = find.byType(ChooseAppointmentBackButton);
    expect(tester.getSize(backButton), const Size(48, 48));

    final arrow = find.descendant(
      of: backButton,
      matching: find.byType(AppImage),
    );
    expect(tester.getSize(arrow), const Size(24, 24));
  });
}
