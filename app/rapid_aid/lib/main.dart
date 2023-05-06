import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rapid_aid/screens/help/help.dart';
import 'package:rapid_aid/screens/home/home.dart';
import 'package:rapid_aid/screens/login/login.dart';
import 'package:rapid_aid/screens/otp_verification/otp_verification.dart';
import 'package:rapid_aid/screens/preventative_measures/preventative_measures.dart';
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
    // Disable device auto orientation and force portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      // Hide debug banner
      debugShowCheckedModeBanner: false,
      // App routes
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/welcome': (context) => const Welcome(),
        '/login': (context) => const Login(),
        '/otp_verification': (context) => const OTPVerification(),
        '/register': (context) => const Registration(),
        '/home': (context) => const Home(),
        '/preventative_measures': (context) => const PreventativeMeasures(),
        '/help': (context) => const Help(),
      },
    );
  }
}
