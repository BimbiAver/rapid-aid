import 'package:flutter/material.dart';
import 'package:rapid_aid/controllers/user_auth_controller.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  // Store data coming from the Login
  Map data = {};

  final _otpVerifyFormKey = GlobalKey<FormState>();
  final _otpFormController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _otpFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
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
                child: Form(
                  key: _otpVerifyFormKey,
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
                      Text(
                        "Enter the OTP sent to ${data['emailOrMobile']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 6,
                          controller: _otpFormController,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          decoration: const InputDecoration(
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
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          // Navigate to the login screen
                          onPressed: () async {
                            if (_otpVerifyFormKey.currentState!.validate()) {
                              await UserAuthController().verify(
                                context: context,
                                emailOrMobile: data['emailOrMobile'],
                                otp: _otpFormController.text,
                              );
                            }
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
