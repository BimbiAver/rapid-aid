import 'package:flutter/material.dart';
import 'package:rapid_aid/screens/login/login.dart';
import 'package:rapid_aid/screens/registration/registration.dart';
import 'package:rapid_aid/screens/splash/splash.dart';
import 'package:rapid_aid/screens/welcome/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide debug banner
      debugShowCheckedModeBanner: false,
      // App routes
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/welcome': (context) => const Welcome(),
        '/login': (context) => const Login(),
        '/register': (context) => const Registration(),
      },
    );
  }
}
