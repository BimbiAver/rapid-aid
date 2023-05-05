import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset('assets/images/wave_red.png'),
        Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: Image.asset(
            'assets/images/icon-white-transparent.png',
            height: 55,
          ),
        ),
      ],
    );
  }
}
