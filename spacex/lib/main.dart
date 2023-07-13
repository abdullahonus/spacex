import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: 'SpaceX Latest Launch',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
