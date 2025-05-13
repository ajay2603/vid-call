import 'package:flutter/material.dart';
import 'package:mobcall/constants/navigator_key.dart';
import 'package:mobcall/screens/home_screen.dart';
import 'package:mobcall/screens/second_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/second': (context) => const SecondScreen(),
      },
    );
  }
}
