import 'package:flutter/material.dart';
import 'package:rapid_aid/widgets/header.dart';
import 'package:rapid_aid/widgets/logout_confirmation.dart';

import '../help/help.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE01E37),
        elevation: 0,
        title: const Text(
          'Hi, Deshan',
          style: TextStyle(
            fontFamily: 'LemonJelly',
            fontSize: 32,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              LogoutConfirmation().logoutConfirmationAlertDialog(context);
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Log Out',
          )
        ],
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: _currentScreen == 0
          ? Column(
              children: [
                const Header(),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2F5FF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: GridView.count(
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 10,
                        ),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        crossAxisCount: 2,
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/report_case.png',
                                      height: 70,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Report Case',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/case.png',
                                      height: 70,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Manage Cases',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/medical_record.png',
                                      height: 70,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Medical Details',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/preventative_measures');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/prevention.png',
                                      height: 70,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Preventative\nMeasures',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/user_account.png',
                                      height: 70,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text(
                                      'Profile',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
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
                      )),
                )
              ],
            )
          : const Help(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFE01E37),
        unselectedItemColor: const Color(0xFF03045E),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              size: 24,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.help,
            ),
            label: 'Help',
          ),
        ],
        currentIndex: _currentScreen,
        onTap: (int index) {
          setState(() {
            _currentScreen = index;
          });
        },
      ),
    );
  }
}
