import 'package:do_it/pages/landing_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Do It',
      theme: ThemeData(
        fontFamily: 'Trocchi',
        colorScheme: ColorScheme.light(
          // seedColor: const Color(0xFF2C3892),
          primary: const Color.fromARGB(255, 41, 57, 173),
          secondary: const Color.fromARGB(255, 81, 173, 229),
          tertiary: const Color.fromARGB(255, 41, 64, 235),
          surface: const Color.fromARGB(255, 236, 248, 255),
          onPrimary: const Color.fromARGB(255, 255, 255, 255),
          onSurface: const Color.fromARGB(255, 0, 0, 0),
        ),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
