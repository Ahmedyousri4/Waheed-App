import 'package:flutter/material.dart';
import 'package:waheed/core/widgets/app_image.dart';
import 'package:waheed/features/auth/get_started_screen.dart';

/// Splash screen shown for 3 seconds before navigating to Get Started.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const GetStartedScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(child: AppImage(image: "logo.svg", height: 120, width: 120)),
          Text(
            "WAHEED HASSAN",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Inter",
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          Text(
            "MEN'S SUITS",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "Inter",
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
