import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
            height: 10,
          ),
          Image.asset(
            'assets/images/logo_transparent.png',
            width: 220,
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/images/splash-illustration.png',
            width: 270,
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Emergencies can happen at any time. Fortunately, RapidAid can help you stay safe in an emergency. With RapidAid, you can inform the situations to the relevant departments when you or someone in an emergency. Selected departments and pre-specified guardians will receive a message with your location, informing them that the person concerned is in an emergency. They will come directly to save you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 26, 26, 26),
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            // Navigate to the login screen
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE01E37),
            ),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}
