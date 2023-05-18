import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:manajemen_spp/main_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/logo.png'),
          const Text(
            'Manajemen SPP',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 145, 108, 237),
      nextScreen: MainPage(),
      splashIconSize: 250,
      duration: 4000,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
