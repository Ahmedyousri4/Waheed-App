import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/auth/login_screen.dart';
import 'package:waheed/features/auth/sign_up_screen.dart';
import 'package:waheed/features/home/home_screen.dart';

Widget _buildTestApp(Widget home) {
  return MaterialApp(locale: const Locale('ar'), home: home);
}

void _setFigmaSurfaceSize(WidgetTester tester) {
  tester.view.physicalSize = const Size(402, 947);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Screen 03 — SignUpScreen UI rendering', () {
    testWidgets('renders all documented fields, headings, and buttons', (
      WidgetTester tester,
    ) async {
      _setFigmaSurfaceSize(tester);
      await tester.pumpWidget(_buildTestApp(const SignUpScreen()));

      expect(find.text('إنشاء حساب'), findsWidgets);
      expect(find.textContaining('لديك حساب بالفعل؟'), findsOneWidget);
      expect(find.textContaining('تسجيل الدخول'), findsOneWidget);
      expect(find.text('الاسم بالكامل'), findsOneWidget);

      expect(find.text('رقم الهاتف'), findsOneWidget);
      expect(find.text('+20'), findsOneWidget);
      expect(find.text('البريد الإلكتروني'), findsOneWidget);
      expect(find.text('كلمة المرور'), findsOneWidget);
      expect(find.text('تأكيد كلمة المرور'), findsOneWidget);
      expect(find.byKey(const Key('signup_button')), findsOneWidget);
      expect(find.text('أو تـــــــابــع بواسطة'), findsOneWidget);
      expect(find.text('Google'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
    });

    testWidgets('password and confirm password toggle independently', (
      WidgetTester tester,
    ) async {
      _setFigmaSurfaceSize(tester);
      await tester.pumpWidget(_buildTestApp(const SignUpScreen()));

      final editables = find.byType(EditableText);
      expect(editables, findsNWidgets(5));

      EditableText passwordField = tester.widget<EditableText>(editables.at(3));
      EditableText confirmField = tester.widget<EditableText>(editables.at(4));
      expect(passwordField.obscureText, isTrue);
      expect(confirmField.obscureText, isTrue);

      // Toggle password visibility
      final passToggle = find.byKey(const Key('signup_password_toggle'));
      await tester.tap(passToggle);
      await tester.pump();

      passwordField = tester.widget<EditableText>(editables.at(3));
      confirmField = tester.widget<EditableText>(editables.at(4));
      expect(passwordField.obscureText, isFalse);
      expect(confirmField.obscureText, isTrue);

      // Toggle confirm password visibility
      final confirmToggle = find.byKey(
        const Key('signup_confirm_password_toggle'),
      );
      await tester.tap(confirmToggle);
      await tester.pump();

      passwordField = tester.widget<EditableText>(editables.at(3));
      confirmField = tester.widget<EditableText>(editables.at(4));
      expect(passwordField.obscureText, isFalse);
      expect(confirmField.obscureText, isFalse);
    });
  });

  group('Screen 03 — SignUpScreen Form Validation', () {
    testWidgets('empty submission displays validation error messages', (
      WidgetTester tester,
    ) async {
      _setFigmaSurfaceSize(tester);
      await tester.pumpWidget(_buildTestApp(const SignUpScreen()));

      final submitBtn = find.byKey(const Key('signup_button'));
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pump();

      expect(find.text('يرجى كتابة الاسم بالكامل'), findsOneWidget);
      expect(find.text('يرجى كتابة رقم الهاتف'), findsOneWidget);
      expect(find.text('يرجى كتابة البريد الإلكتروني'), findsOneWidget);
      expect(find.text('يرجى كتابة كلمة المرور'), findsOneWidget);
      expect(find.text('يرجى تأكيد كلمة المرور'), findsOneWidget);
    });

    testWidgets('validates invalid email syntax and password mismatch', (
      WidgetTester tester,
    ) async {
      _setFigmaSurfaceSize(tester);
      await tester.pumpWidget(_buildTestApp(const SignUpScreen()));

      final editables = find.byType(EditableText);
      await tester.enterText(editables.at(0), 'أحمد يسري');
      await tester.enterText(editables.at(1), '1012345678');
      await tester.enterText(editables.at(2), 'invalid-email');
      await tester.enterText(editables.at(3), '123456');
      await tester.enterText(editables.at(4), '654321');

      final submitBtn = find.byKey(const Key('signup_button'));
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pump();

      expect(find.text('صيغة البريد الإلكتروني غير صحيحة'), findsOneWidget);
      expect(find.text('كلمتا المرور غير متطابقتين'), findsOneWidget);
    });

    testWidgets('valid submission succeeds and navigates to HomeScreen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(const SignUpScreen()));

      final editables = find.byType(EditableText);
      await tester.enterText(editables.at(0), 'أحمد يسري');
      await tester.enterText(editables.at(1), '1012345678');
      await tester.enterText(editables.at(2), 'user@example.com');
      await tester.enterText(editables.at(3), 'secret123');
      await tester.enterText(editables.at(4), 'secret123');

      final submitBtn = find.byKey(const Key('signup_button'));
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('invalid form submission does not navigate to HomeScreen', (
      WidgetTester tester,
    ) async {
      _setFigmaSurfaceSize(tester);
      await tester.pumpWidget(_buildTestApp(const SignUpScreen()));

      final submitBtn = find.byKey(const Key('signup_button'));
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(SignUpScreen), findsOneWidget);
    });

    testWidgets('scroll view has onDrag keyboard dismissal behavior', (
      WidgetTester tester,
    ) async {
      _setFigmaSurfaceSize(tester);
      await tester.pumpWidget(_buildTestApp(const SignUpScreen()));

      final scrollFinder = find.byType(SingleChildScrollView);
      expect(scrollFinder, findsOneWidget);
      final scrollView = tester.widget<SingleChildScrollView>(scrollFinder);
      expect(
        scrollView.keyboardDismissBehavior,
        ScrollViewKeyboardDismissBehavior.onDrag,
      );
    });

    testWidgets('uses AppImage for background, icons, and vector assets', (
      WidgetTester tester,
    ) async {
      _setFigmaSurfaceSize(tester);
      await tester.pumpWidget(_buildTestApp(const SignUpScreen()));

      expect(find.byType(AppImage), findsWidgets);
    });
  });

  group('Navigation Flow — Login to SignUp and back', () {
    testWidgets(
      'tapping account prompt link in LoginScreen navigates to SignUpScreen',
      (WidgetTester tester) async {
        _setFigmaSurfaceSize(tester);
        await tester.pumpWidget(_buildTestApp(const LoginScreen()));

        final promptFinder = find.byKey(const Key('account_prompt_link'));
        expect(promptFinder, findsOneWidget);

        await tester.tap(promptFinder);
        await tester.pumpAndSettle();

        expect(find.byType(SignUpScreen), findsOneWidget);
        expect(find.text('الاسم بالكامل'), findsOneWidget);
      },
    );

    testWidgets(
      'tapping تسجيل الدخول link in SignUpScreen returns to LoginScreen',
      (WidgetTester tester) async {
        _setFigmaSurfaceSize(tester);
        await tester.pumpWidget(_buildTestApp(const LoginScreen()));

        // Go from Login to SignUp
        await tester.tap(find.byKey(const Key('account_prompt_link')));
        await tester.pumpAndSettle();
        expect(find.byType(SignUpScreen), findsOneWidget);

        // Tap link to return to Login
        final loginLinkFinder = find.byKey(const Key('login_link'));
        expect(loginLinkFinder, findsOneWidget);
        await tester.tap(loginLinkFinder);
        await tester.pumpAndSettle();

        expect(find.byType(LoginScreen), findsOneWidget);
        expect(find.text('تسجيل الدخول'), findsWidgets);
      },
    );
  });
}
