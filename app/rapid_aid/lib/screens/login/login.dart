import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visibility = true; // Visibility for TextFields
  String title = 'Login with Email';
  String discription =
      "Log in to continue to RapidAid. Your email address will be safe with us. We won't share your details with anyone.";
  String loginWith = 'Log in with your mobile number';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE01E37),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
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
                    'assets/images/logo_transparent.png',
                    width: 220,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    discription,
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
                  Visibility(
                    visible: visibility,
                    child: const TextField(
                      maxLines: 1,
                      maxLength: 25,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF03045E),
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                        hintText: "email@example.com",
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: Colors.black,
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !visibility,
                    child: const TextField(
                      maxLines: 1,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF03045E),
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',
                        hintText: "07XXXXXXXX",
                        prefixIcon: Icon(Icons.phone_iphone),
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
                    width: 130,
                    child: ElevatedButton(
                      // Navigate to the login screen
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE01E37),
                      ),
                      child: const Text('Log In'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (visibility == true) {
                          visibility = false;
                          loginWith = 'Log in with your email address';
                          title = 'Login with Number';
                          discription =
                              "Log in to continue to RapidAid. Your mobile number will be safe with us. We won't share your details with anyone.";
                        } else {
                          visibility = true;
                          loginWith = 'Log in with your mobile number';
                          title = 'Login with Email';
                          discription =
                              "Log in to continue to RapidAid. Your email address will be safe with us. We won't share your details with anyone.";
                        }
                      });
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 30),
                    ),
                    child: Text(
                      loginWith,
                      style: const TextStyle(
                        color: Color(0xFF03045E),
                      ),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                    child: TextButton(
                      // Navigate to the registration screen
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 30),
                      ),
                      child: const Text(
                        "Don't have an account? Register here",
                        style: TextStyle(
                          color: Color(0xFF03045E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
