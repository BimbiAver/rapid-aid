import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rapid_aid/utils/secure_storage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // Create an instance of SecureStorge class
  final _secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    // Check connections and token
    _checkConnections();
  }

  void _checkConnections() async {
    // Check whether the Internet connection is available
    if (!await _checkNetwork()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('To continue, please connect to the Internet!'),
        ),
      );
      // Exit app after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        exit(1);
      });
    } else if (!await Geolocator.isLocationServiceEnabled()) {
      // Check whether the device location is enabled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('To continue, please turn on device location!'),
        ),
      );
      // Exit app after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        exit(1);
      });
    } else {
      // Check whether the user is already logged in or not
      checkToken();
    }
  }

  Future<bool> _checkNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // Check whether the user is already logged in or not
  checkToken() async {
    if (await _secureStorage.getToken() != null) {
      // Navigate to the home screen after N seconds
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else {
      // Navigate to the welcome screen after N seconds
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/welcome');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE01E37),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
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
