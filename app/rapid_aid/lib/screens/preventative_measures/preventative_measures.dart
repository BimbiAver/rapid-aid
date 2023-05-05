import 'package:flutter/material.dart';

import '../../widgets/header.dart';

class PreventativeMeasures extends StatelessWidget {
  const PreventativeMeasures({super.key});

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
        child: Column(
          children: [
            const Header(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Text(
                    '🔴 Please follow the standard precautions!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '- Prepare and Prevent, instead of repair and repent -',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Card(
                        elevation: 1.5,
                        color: const Color(0xFFF2F5FF),
                        child: ExpansionTile(
                          title: const Text(
                            'Before an emergency',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: [
                            Container(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              child: const Text(
                                'Hazards vary depending on where you live. Identify the hazards near you so you can create your emergency plan.  Emergencies affect us all differently and help is not always available in the way we expect. Learn what steps you can take to ensure your needs are met when it matters most.   •Be prepared •Be informed •Connect with neighbours •Financial preparedness •Protect your pets',
                                style: TextStyle(
                                  height: 1.4,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 1.5,
                        color: const Color(0xFFF2F5FF),
                        child: ExpansionTile(
                          title: const Text(
                            'During an emergency',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: [
                            Container(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              child: const Text(
                                'Emergencies have the potential to cause serious harm to people, property, the economy and the environment. Make sure you know who to call and what to do during an emergency or disaster.  Protecting yourself and your loved ones will depend on the hazard, but these tips can help you manage emergencies and disasters safely.  •Shelter-in-place •Evacuation alerts and orders •Emergency evacuation payments •Stay informed •Connect with neighbours •If there is time •We are all in this together',
                                style: TextStyle(
                                  height: 1.4,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 1.5,
                        color: const Color(0xFFF2F5FF),
                        child: ExpansionTile(
                          title: const Text(
                            'After an emergency',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: [
                            Container(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              child: const Text(
                                "The lingering effects of unexpected emergencies and disasters are different for everyone. Knowing what to do after an emergency can help reduce stress and aid in a quicker recovery.  If you had to evacuate, you cannot return home until authorities have told you it's safe to do so. Use extreme caution at all times.  Being prepared can help speed up your recovery time, so you can get back to your life and work sooner.  •Recovery is a process •Re-entry •Connect with neighbours •Your mental health •Recovery assistance •We are all in this together",
                                style: TextStyle(
                                  height: 1.4,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 1.5,
                        color: const Color(0xFFF2F5FF),
                        child: ExpansionTile(
                          title: const Text(
                            'Helping others',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: [
                            Container(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              padding: const EdgeInsets.all(20),
                              width: double.infinity,
                              child: const Text(
                                "Check with your community to learn how to help others during severe weather events. If you are concerned for someone's safety, call:  •119 if someone is in distress or in an unsafe place •1990 if they're unconscious or need medical help",
                                style: TextStyle(
                                  height: 1.4,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
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
