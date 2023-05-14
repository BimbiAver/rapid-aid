import 'package:flutter/material.dart';
import 'package:rapid_aid/models/case_model.dart';
import 'package:rapid_aid/widgets/header.dart';

class SelectSituation extends StatefulWidget {
  const SelectSituation({super.key});

  @override
  State<SelectSituation> createState() => _SelectSituationState();
}

class _SelectSituationState extends State<SelectSituation> {
  CaseModel caseModel = CaseModel();

  // Select the situation and navigate to the next screen
  void _selectSituation(String situation) {
    caseModel.situation = situation;
    Navigator.pushNamed(context, '/select_department', arguments: {
      'caseModel': caseModel,
    });
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const Text(
                  'Select the Situation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {
                            _selectSituation('Accident');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/car_accident.png',
                                  height: 35,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  'Accident',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {
                            _selectSituation('Attack');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/fight.png',
                                  height: 35,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  'Attack',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {
                            _selectSituation('Robbery');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/robbery.png',
                                  height: 35,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  'Robbery',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {
                            _selectSituation('Kidnap');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/kidnap.png',
                                  height: 35,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  'Kidnap',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      _selectSituation('Medical Emergency');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/medical_emergency.png',
                            height: 35,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            'Medical Emergency',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      _selectSituation('Sexual Harassment');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/sexual_harassment.png',
                            height: 35,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            'Sexual Harassment',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      _selectSituation('Fire Incident');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/fire_incident.png',
                            height: 35,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            'Fire Incident',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      _selectSituation('Natural Disaster');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/natural_disaster.png',
                            height: 35,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            'Natural Disaster',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      _selectSituation('Other Incident');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/other.png',
                            height: 35,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            'Other Incident',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
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
