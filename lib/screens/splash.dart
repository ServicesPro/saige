import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        "assets/saige_logo.png",
        height: 250.0,
      ),
      splashIconSize: 250.0,
      nextScreen: Home(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Colors.white,
      duration: 3000,
      curve: Curves.easeInOutQuad,
    );
  }
}
