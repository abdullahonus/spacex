import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex/splash/splash_screen.dart';

import 'providers/launch_providers.dart';
import 'screens/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => LaunchProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SpaceX Latest Launch',
        home: AnimatedSplashScreen(
            duration: 1000,
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Color.fromARGB(255, 3, 18, 31),
            nextScreen: HomeScreen(),
            animationDuration: const Duration(seconds: 2),
            splash: Image.asset(
              color: Colors.white,
              width: MediaQuery.of(context).size.width / 1.17,
              'assets/logo/logo.png',
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}
