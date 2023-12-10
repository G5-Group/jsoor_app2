import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'dart:ui' as ui;

import 'package:jsoor_app2/my_app.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,

        pages: [
          PageViewModel(
            titleWidget: const Text(
              "Jsoor",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: "One Sign at a Time Your Voice in Every Hand.",
            image: Image.asset(
              "images/intro1.png",
              height: 400,
              width: 400,
            ),
          ),

          PageViewModel(
            titleWidget: const Text(
              "Sign to words",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            body:
                "Seamlessly bridge the gap between sign language and text with our intuitive app."
                " Instantly translate sign language gestures to text, enhancing communication for everyone.",
            image: Image.asset(
              "images/intro2.gif",
              height: 400,
              width: 400,
            ),
          ),

//--------------------------------------------------------------------------------------
          // page 3
          PageViewModel(
            titleWidget: const Text(
              "Text to voice",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            body:
                "Not only does the app translate sign language to text, but it also brings it to life with vocalized translations – SignCam: Bridging Conversations with Clarity",
            image: Image.asset(
              "images/jsoorimg.png",
              height: 400,
              width: 400,
            ),
          ),
        ],

//--------------------------------------------------------------------------------------

        onDone: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        },

        onSkip: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        },
        showSkipButton: true,

        //----skip-----
        skip: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFF8cc7e6), width: 2.0),
            color: const Color(0xFF8cc7e6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: const Text(
            "Skip",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),

        //----next-----
        next: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFF8cc7e6), width: 2.0),
            color: const Color(0xFF8cc7e6),
          ),
          padding: const EdgeInsets.all(8.0),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),

        //----Done-----
        done: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFF8cc7e6), width: 2.0),
            color: const Color(0xFF8cc7e6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: const Text(
            "Done",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),

        dotsDecorator: DotsDecorator(
          size: const ui.Size.square(10.0),
          activeSize: const ui.Size(20.0, 10.0),
          color: Colors.black26,
          activeColor: const Color(0xFF8cc7e6),
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
