import 'package:flutter/material.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/auth/login_screen.dart';
import 'package:waheed/features/auth/utils/auth_styles.dart';
import 'package:waheed/features/auth/utils/signup_validator.dart';
import 'package:waheed/features/auth/widgets/auth_text_field.dart';
import 'package:waheed/features/auth/widgets/phone_input_field.dart';
import 'package:waheed/features/auth/widgets/signup_cta_button.dart';
import 'package:waheed/features/auth/widgets/signup_header.dart';
import 'package:waheed/features/auth/widgets/signup_password_fields.dart';
import 'package:waheed/features/auth/widgets/signup_social_section.dart';
import 'package:waheed/features/auth/widgets/signup_system_bar.dart';
import 'package:waheed/features/home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String nameLabel = 'الاسم بالكامل';
  static const String nameHint = 'اكتب اسمك الكامل';
  static const String phoneLabel = 'رقم الهاتف';
  static const String phoneHint = '102233558';
  static const String emailLabel = 'البريد الإلكتروني';
  static const String emailHint = 'Name@example.com';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isSubmitting = false;

  String? _nameError;
  String? _phoneError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _onNavigateToLogin() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  bool _validateForm() {
    final nameErr = SignUpValidator.validateName(_nameController.text);
    final phoneErr = SignUpValidator.validatePhone(_phoneController.text);
    final emailErr = SignUpValidator.validateEmail(_emailController.text);
    final passErr = SignUpValidator.validatePassword(_passwordController.text);
    final confirmErr = SignUpValidator.validateConfirmPassword(
      _confirmPasswordController.text,
      _passwordController.text,
    );

    setState(() {
      _nameError = nameErr;
      _phoneError = phoneErr;
      _emailError = emailErr;
      _passwordError = passErr;
      _confirmPasswordError = confirmErr;
    });

    return nameErr == null &&
        phoneErr == null &&
        emailErr == null &&
        passErr == null &&
        confirmErr == null;
  }

  void _onSubmitSignUp() {
    if (_isSubmitting) return;
    if (!_validateForm()) return;

    setState(() => _isSubmitting = true);

    // Form inputs are fully validated. As with LoginScreen, navigate to
    // HomeScreen via pushReplacement using the established routing convention.
    // Note: No backend registration service exists in the project; navigation
    // is performed locally following successful client-side validation.
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
          // Background photo with 70% black overlay pinned to screen height
          // to prevent keyboard-induced resizing or recropping.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const AppImage(image: 'background.jpg', fit: BoxFit.cover),
                Container(color: AuthStyles.photoOverlay70),
              ],
            ),
          ),
          // White signup sheet positioned at y=180
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: Container(
              decoration: const BoxDecoration(
                color: AuthStyles.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
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
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Centered heading group
                      SignUpHeader(onLoginTap: _onNavigateToLogin),
                      const SizedBox(height: 16),
                      // Full Name input field
                      AuthTextField(
                        label: SignUpScreen.nameLabel,
                        hintText: SignUpScreen.nameHint,
                        controller: _nameController,
                        focusNode: _nameFocus,
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.rtl,
                        height: 48,
                        borderRadius: 12,
                        borderColor: AuthStyles.fieldBorder,
                        horizontalPadding: 16,
                        verticalPadding: 8,
                        labelStyle: AuthStyles.signUpFieldLabel,
                        hintStyle: AuthStyles.signUpFieldHint,
                        errorText: _nameError,
                        suffixIcon: const AppImage(
                          image: 'profilee.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Phone input field (+20 prefix)
                      PhoneInputField(
                        label: SignUpScreen.phoneLabel,
                        hintText: SignUpScreen.phoneHint,
                        controller: _phoneController,
                        focusNode: _phoneFocus,
                        textInputAction: TextInputAction.next,
                        errorText: _phoneError,
                      ),
                      const SizedBox(height: 8),
                      // Email input field
                      AuthTextField(
                        label: SignUpScreen.emailLabel,
                        hintText: SignUpScreen.emailHint,
                        controller: _emailController,
                        focusNode: _emailFocus,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textDirection: TextDirection.ltr,
                        height: 48,
                        borderRadius: 12,
                        borderColor: AuthStyles.fieldBorder,
                        horizontalPadding: 16,
                        verticalPadding: 8,
                        labelStyle: AuthStyles.signUpFieldLabel,
                        hintStyle: AuthStyles.signUpFieldHint,
                        errorText: _emailError,
                        suffixIcon: const AppImage(
                          image: 'email.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Password and Confirm Password group
                      SignUpPasswordFields(
                        passwordController: _passwordController,
                        passwordFocusNode: _passwordFocus,
                        confirmPasswordController: _confirmPasswordController,
                        confirmPasswordFocusNode: _confirmPasswordFocus,
                        obscurePassword: _obscurePassword,
                        obscureConfirmPassword: _obscureConfirmPassword,
                        onTogglePassword: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                        onToggleConfirmPassword: () {
                          setState(
                            () =>
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword,
                          );
                        },
                        passwordError: _passwordError,
                        confirmPasswordError: _confirmPasswordError,
                        onSubmitted: (_) => _onSubmitSignUp(),
                      ),
                      const SizedBox(height: 24),
                      // Create Account Button
                      SignUpCtaButton(
                        onTap: _onSubmitSignUp,
                        isLoading: _isSubmitting,
                      ),
                      const SizedBox(height: 16),
                      // Social divider and provider buttons
                      const SignUpSocialSection(),
                      const SizedBox(height: 16),
                      // Bottom system indicator bar
                      const SignUpSystemBar(),
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
