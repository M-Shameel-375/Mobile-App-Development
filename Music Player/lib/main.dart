import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // Add this import

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF1DB954),
      ),
      home: const SplashScreen(), // Change to SplashScreen
    );
  }
}