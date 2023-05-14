import 'package:flutter/material.dart';
import 'package:rapid_aid/models/case_model.dart';
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
  bool _mwca = false;

  // Store data coming from the previous screen
  Map data = {};

  late CaseModel caseModel;

  // Select department(s)
  void _selectDepartment() {
    switch (caseModel.situation) {
      case 'Accident':
        setState(() {
          _hospital = true;
          _police = true;
        });
        break;
      case 'Attack':
        setState(() {
          _hospital = true;
          _police = true;
        });
        break;
      case 'Robbery':
        setState(() {
          _hospital = true;
          _police = true;
        });
        break;
      case 'Kidnap':
        setState(() {
          _hospital = true;
          _police = true;
        });
        break;
      case 'Medical Emergency':
        setState(() {
          _hospital = true;
          _police = true;
        });
        break;
      case 'Sexual Harassment':
        setState(() {
          _hospital = true;
          _police = true;
          _mwca = true;
        });
        break;
      case 'Fire Incident':
        setState(() {
          _hospital = true;
          _police = true;
          _fireBrigade = true;
        });
        break;
      case 'Natural Disaster':
        setState(() {
          _hospital = true;
          _police = true;
          _dmc = true;
        });
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    // Select department(s) automatically
    Future.delayed(Duration.zero, () {
      caseModel = data['caseModel'];
      _selectDepartment();
    });
  }

  // Set departments
  _setDepartment() {
    Departments departments = Departments();
    if (_police) {
      Department police = Department();
      police.assign = true;
      police.status = 'New';
      departments.police = police;
    }
    if (_hospital) {
      Department hospital = Department();
      hospital.assign = true;
      hospital.status = 'New';
      departments.hospital = hospital;
    }
    if (_fireBrigade) {
      Department fireBrigade = Department();
      fireBrigade.assign = true;
      fireBrigade.status = 'New';
      departments.fireBrigade = fireBrigade;
    }
    if (_dmc) {
      Department dmc = Department();
      dmc.assign = true;
      dmc.status = 'New';
      departments.dmc = dmc;
    }
    if (_mwca) {
      Department mwca = Department();
      mwca.assign = true;
      mwca.status = 'New';
      departments.mwca = mwca;
    }
    caseModel.departments = departments;
  }

  @override
  Widget build(BuildContext context) {
    // Get arguments
    data = ModalRoute.of(context)!.settings.arguments as Map;
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
                          value: _mwca,
                          onChanged: (bool? value) {
                            setState(() {
                              _mwca = value!;
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
                    onPressed: () {
                      // Set departments on CaseModel
                      _setDepartment();
                      // Validate checkboxes
                      if (_police == true ||
                          _hospital == true ||
                          _fireBrigade == true ||
                          _dmc == true ||
                          _mwca == true) {
                        // Navigate to the Case Details screen
                        Navigator.pushNamed(context, '/case_details',
                            arguments: {
                              'caseModel': caseModel,
                            });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please select at least one department!'),
                          ),
                        );
                      }
                    },
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
