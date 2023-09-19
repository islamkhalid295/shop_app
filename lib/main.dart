import 'package:flutter/material.dart';

import 'modules/onboarding.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.orange.shade100,
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,

      ),
      home: OnBoardingScreen(),
    );
  }
}

