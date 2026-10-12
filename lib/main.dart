import 'package:flutter/material.dart';
import 'landing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        useMaterial3: true,
        // Light grey background used by every Scaffold in the app.
        scaffoldBackgroundColor: const Color(0xFFEDEFF3),
      ),
      // First screen of the app is now the Landing Page.
      home: const LandingPage(),
    );
  }
}