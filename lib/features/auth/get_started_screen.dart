import 'package:flutter/material.dart';
import 'package:waheed/features/auth/login_screen.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';

/// Screen 01 — Get Started (البدء الآن)
///
/// Implements Figma node 549:8382 with user-confirmed typography,
/// real background imagery (assets/images/background.jpg), and
/// navigation to Screen 02 (Login).
class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  static const String titleText = 'إطلالة تليق بك';
  static const String subtitleText =
      'تسوّق أو استأجر بدلتك المفضلة بخطوات بسيطة وتجربة فاخرة.';
  static const String descriptionText =
      'مجموعة حصرية من البدلات والإكسسوارات الفاخرة...';
  static const String ctaLabel = 'البدء الآن';

  void _onGetStarted(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthStyles.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned.fill(child: Container(color: AuthStyles.photoOverlay)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AuthStyles.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 20,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        titleText,
                        textAlign: TextAlign.center,
                        style: AuthStyles.title,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        subtitleText,
                        textAlign: TextAlign.center,
                        style: AuthStyles.subtitle,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        descriptionText,
                        textAlign: TextAlign.right,
                        style: AuthStyles.description,
                      ),
                      const SizedBox(height: 24),
                      Material(
                        key: const Key('get_started_button'),
                        color: AuthStyles.black,
                        borderRadius: BorderRadius.circular(16),
                        elevation: 4,
                        shadowColor: const Color(0x33000000),
                        child: InkWell(
                          onTap: () => _onGetStarted(context),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 56,
                            alignment: Alignment.center,
                            child: const Text(
                              ctaLabel,
                              style: AuthStyles.ctaButton,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
