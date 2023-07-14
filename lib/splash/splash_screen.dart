// ignore_for_file: non_constant_identifier_names

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:spacex/screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return AnimatedSplashScreen(
            duration: 1000,
            splashTransition: SplashTransition.scaleTransition,
            nextScreen: HomeScreen(),
            splash: Image.asset(
              'assets/logo/logo.png',
              fit: BoxFit.fill,
            ),
          );
        } else {
          return const Center(
            child: SizedBox(
              width: 17,
              height: 17,
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
      },
    );
  }
}
