import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jsoor_app2/screens/on_boarding_page.dart';

//****************************************************************************
// PhoneApplicationPage (class 1)
class PhoneApplicationPage extends StatefulWidget {
  const PhoneApplicationPage({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<PhoneApplicationPage> {
  @override
  void initState() {
    super.initState();

    // Start the timer for 3 seconds
    Timer(const Duration(seconds: 2), () {
      // Navigate to the onboarding screen after 3 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8cc7e6),
              Color(0xFF75afd2),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  width: 250,
                  height: 200,
                  child: Image.asset(
                    'images/Jsoor.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white), // تعيين لون التحميل إلى الأبيض
              ),
            ],
          ),
        ),
      ),
    );
  }
}
