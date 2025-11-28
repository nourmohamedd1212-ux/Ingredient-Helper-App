import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'onboarding_screen.dart'; // your onboarding screen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ingredient Helper App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: SplashScreen(), // splash appears first
    );
  }
}
