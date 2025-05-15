import 'package:flutter/material.dart';
import 'package:mobcall/constants.dart';
import "package:mobcall/screens/auth/signin.dart";
import "package:mobcall/screens/auth/signup.dart";
import "package:mobcall/screens/initilization.dart";
import "package:mobcall/screens/home_screen.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Initialization(),
        '/home': (context) => HomeScreen(),
        '/signin': (context) => const SingInScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}
