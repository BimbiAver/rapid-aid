import 'package:flutter/material.dart';

class OTPVerification extends StatelessWidget {
  const OTPVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE01E37),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus
              ?.unfocus(), // Hide the soft keyboard
          child: Column(
            children: [
              Image.asset('assets/images/wave_red.png'),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/otp_verification.png',
                      height: 150,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      'OTP Verification',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Enter the OTP sent to +9774246925',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const SizedBox(
                      width: 200,
                      child: TextField(
                        maxLines: 1,
                        maxLength: 6,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF03045E),
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          hintText: "XXXXXX",
                          prefixIcon: Icon(Icons.password),
                          prefixIconColor: Colors.black,
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        // Navigate to the login screen
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/home',
                              (Route<dynamic> route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE01E37),
                        ),
                        child: const Text('Verify'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
