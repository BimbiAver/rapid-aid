import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login screen after N seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE01E37),
        elevation: 0,
      ),
      body: Column(
        children: [
          Image.asset('assets/images/wave_red.png'),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/logo_transparent.png',
            width: 250,
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/images/splash-illustration.png',
            width: 300,
          ),
          const SizedBox(
            height: 100,
          ),
          const SpinKitChasingDots(
            color: Color(0xFFE01E37),
            size: 50.0,
          ),
        ],
      ),
    );
  }
}
