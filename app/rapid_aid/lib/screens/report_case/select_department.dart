import 'package:flutter/material.dart';
import 'package:rapid_aid/widgets/header.dart';

class SelectDepartment extends StatefulWidget {
  const SelectDepartment({super.key});

  @override
  State<SelectDepartment> createState() => _SelectDepartmentState();
}

class _SelectDepartmentState extends State<SelectDepartment> {
  bool _police = false;
  bool _hospital = false;
  bool _fireBrigade = false;
  bool _dmc = false;
  bool _wmca = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE01E37),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          const Header(),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 300,
            child: Column(
              children: [
                const Text(
                  'Select the Department(s)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: const Text('Police'),
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: Colors.white,
                          value: _police,
                          onChanged: (bool? value) {
                            setState(() {
                              _police = value!;
                            });
                          },
                          activeColor: const Color(0xFF03045E),
                        ),
                        CheckboxListTile(
                          title: const Text('Hospital'),
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: Colors.white,
                          value: _hospital,
                          onChanged: (bool? value) {
                            setState(() {
                              _hospital = value!;
                            });
                          },
                          activeColor: const Color(0xFF03045E),
                        ),
                        CheckboxListTile(
                          title: const Text('Fire Brigade'),
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: Colors.white,
                          value: _fireBrigade,
                          onChanged: (bool? value) {
                            setState(() {
                              _fireBrigade = value!;
                            });
                          },
                          activeColor: const Color(0xFF03045E),
                        ),
                        CheckboxListTile(
                          title: const Text('DMC - Disaster Management Centre'),
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: Colors.white,
                          value: _dmc,
                          onChanged: (bool? value) {
                            setState(() {
                              _dmc = value!;
                            });
                          },
                          activeColor: const Color(0xFF03045E),
                        ),
                        CheckboxListTile(
                          title: const Text(
                              'MWCA - Ministry of Women and Child Affairs'),
                          controlAffinity: ListTileControlAffinity.leading,
                          checkColor: Colors.white,
                          value: _wmca,
                          onChanged: (bool? value) {
                            setState(() {
                              _wmca = value!;
                            });
                          },
                          activeColor: const Color(0xFF03045E),
                        ),
                      ],
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
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE01E37),
                    ),
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
