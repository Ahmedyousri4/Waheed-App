import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waheed/features/auth/get_started_screen.dart';
import 'package:waheed/features/auth/login_screen.dart';
import 'package:waheed/features/home/home_screen.dart';
import 'package:waheed/features/splash/splash_screen.dart';

Widget _buildTestApp(Widget home) {
  return MaterialApp(locale: const Locale('ar'), home: home);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Screen 01 — GetStartedScreen tests', () {
    testWidgets('renders exact user-approved text strings and CTA', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(const GetStartedScreen()));

      expect(find.text('إطلالة تليق بك'), findsOneWidget);
      expect(
        find.text('تسوّق أو استأجر بدلتك المفضلة بخطوات بسيطة وتجربة فاخرة.'),
        findsOneWidget,
      );
      expect(
        find.text('مجموعة حصرية من البدلات والإكسسوارات الفاخرة...'),
        findsOneWidget,
      );
      expect(find.text('البدء الآن'), findsOneWidget);
    });

    testWidgets('tapping CTA navigates to LoginScreen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(const GetStartedScreen()));

      final ctaFinder = find.text('البدء الآن');
      expect(ctaFinder, findsOneWidget);

      await tester.tap(ctaFinder);
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('تسجيل الدخول'), findsWidgets);
    });
  });

  group('Screen 02 — LoginScreen tests', () {
    testWidgets('renders all documented text, fields, and buttons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(const LoginScreen()));

      expect(find.text('تسجيل الدخول'), findsWidgets);
      expect(find.text('ليس لديك حساب ؟ إنشاء حساب جديد'), findsOneWidget);
      expect(find.text('البريد الالكتروني'), findsOneWidget);
      expect(find.text('Name@example.com'), findsOneWidget);
      expect(find.text('كلمة المرور'), findsWidgets);
      expect(find.text('هل نسيت كلمة المرور ؟'), findsOneWidget);
      expect(find.text('أو تابع بواسطة'), findsOneWidget);
      expect(find.text('Google'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
    });

    testWidgets('password field toggles obscureText when eye icon tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(const LoginScreen()));

      // Initially password text field has obscureText = true
      final editableFinder = find.byType(EditableText);
      expect(editableFinder, findsNWidgets(2));

      EditableText passwordField = tester.widget<EditableText>(
        editableFinder.at(1),
      );
      expect(passwordField.obscureText, isTrue);

      // Tap toggle eye icon
      final eyeFinder = find.byWidgetPredicate(
        (widget) =>
            widget is GestureDetector &&
            widget.child.toString().contains('eye'),
      );
      expect(eyeFinder, findsOneWidget);

      await tester.tap(eyeFinder);
      await tester.pump();

      passwordField = tester.widget<EditableText>(editableFinder.at(1));
      expect(passwordField.obscureText, isFalse);

      // Tap again to obscure
      await tester.tap(eyeFinder);
      await tester.pump();

      passwordField = tester.widget<EditableText>(editableFinder.at(1));
      expect(passwordField.obscureText, isTrue);
    });

    testWidgets('tapping login button navigates to HomeScreen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(const LoginScreen()));

      // Find the login button by key
      final buttonFinder = find.byKey(const Key('login_button'));
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });

  group('Navigation Flow — Splash to Get Started', () {
    testWidgets('SplashScreen navigates to GetStartedScreen after 3 seconds', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(const SplashScreen()));

      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.byType(GetStartedScreen), findsNothing);

      // Fast-forward past the 3-second delay
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.byType(GetStartedScreen), findsOneWidget);
      expect(find.text('إطلالة تليق بك'), findsOneWidget);
    });
  });
}
