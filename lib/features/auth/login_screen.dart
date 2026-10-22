import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';
import 'package:waheed/features/auth/widgets/auth_text_field.dart';
import 'package:waheed/features/auth/widgets/social_login_button.dart';
import 'package:waheed/features/home/home_screen.dart';

/// Screen 02 — Login (تسجيل الدخول)
///
/// Implements Figma node 549:8392 with confirmed shared typography,
/// email/password fields with password visibility toggle, forgot-password link,
/// primary login action, divider, and Google/Apple social sign-in options.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String titleText = 'تسجيل الدخول';
  static const String accountPromptText = 'ليس لديك حساب ؟ إنشاء حساب جديد';
  static const String emailLabel = 'البريد الالكتروني';
  static const String emailHint = 'Name@example.com';
  static const String passwordLabel = 'كلمة المرور';
  static const String passwordHint = 'كلمة المرور';
  static const String forgotPasswordText = 'هل نسيت كلمة المرور ؟';
  static const String loginButtonLabel = 'تسجيل الدخول';
  static const String dividerCaption = 'أو تابع بواسطة';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onTogglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _onLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthStyles.white,
      body: Stack(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/background.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                Container(color: AuthStyles.photoOverlay),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Container(
              decoration: const BoxDecoration(
                color: AuthStyles.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 16,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        LoginScreen.titleText,
                        textAlign: TextAlign.center,
                        style: AuthStyles.title,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        LoginScreen.accountPromptText,
                        textAlign: TextAlign.center,
                        style: AuthStyles.subtitle,
                      ),
                      const SizedBox(height: 28),
                      AuthTextField(
                        label: LoginScreen.emailLabel,
                        hintText: LoginScreen.emailHint,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.ltr,
                        suffixIcon: SvgPicture.asset(
                          'assets/icons/email.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const SizedBox(height: 18),
                      AuthTextField(
                        label: LoginScreen.passwordLabel,
                        hintText: LoginScreen.passwordHint,
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        textDirection: TextDirection.rtl,
                        prefixIcon: GestureDetector(
                          onTap: _onTogglePasswordVisibility,
                          behavior: HitTestBehavior.opaque,
                          child: SvgPicture.asset(
                            _obscurePassword
                                ? 'assets/icons/eyeoff.svg'
                                : 'assets/icons/eye.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            LoginScreen.forgotPasswordText,
                            style: AuthStyles.forgotPassword,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Material(
                        key: const Key('login_button'),
                        color: AuthStyles.black,
                        borderRadius: BorderRadius.circular(16),
                        elevation: 4,
                        shadowColor: const Color(0x33000000),
                        child: InkWell(
                          onTap: _onLogin,
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 56,
                            alignment: Alignment.center,
                            child: const Text(
                              LoginScreen.loginButtonLabel,
                              style: AuthStyles.ctaButton,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              color: AuthStyles.divider,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              LoginScreen.dividerCaption,
                              style: AuthStyles.dividerText,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AuthStyles.divider,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        textDirection: TextDirection.ltr,
                        children: [
                          SocialLoginButton(
                            label: 'Google',
                            iconPath: 'assets/icons/googel.svg',
                            iconWidth: 18,
                            iconHeight: 18,
                            onTap: () {},
                          ),
                          const SizedBox(width: 14),
                          SocialLoginButton(
                            label: 'Apple',
                            iconPath: 'assets/icons/appel.svg',
                            iconWidth: 15,
                            iconHeight: 18,
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
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
