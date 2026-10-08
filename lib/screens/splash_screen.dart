import 'package:flutter/material.dart';
import '../screens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const SplashScreen({super.key, required this.onThemeChanged});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => Onboarding(onThemeChanged: widget.onThemeChanged),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/Evently.png')),
    );
  }
}
