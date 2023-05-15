import 'package:flutter/material.dart';
import 'package:rapid_aid/controllers/case_controller.dart';
import 'package:rapid_aid/models/case_model.dart';
import 'package:rapid_aid/widgets/case_list_card.dart';
import 'package:rapid_aid/widgets/header.dart';

class Cases extends StatefulWidget {
  const Cases({super.key});

  @override
  State<Cases> createState() => _CasesState();
}

class _CasesState extends State<Cases> {
  List<CaseModel>? _caseModel = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getCases(); // Get cases
    });
  }

  // Get cases
  void _getCases() async {
    _caseModel = (await CaseController().getCases(context: context));
    // Sort the list in descending order
    _caseModel?.sort((a, b) => (b.dateTime)!.compareTo(a.dateTime.toString()));
    setState(() {});
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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus
            ?.unfocus(), // Hide the soft keyboard
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
                    'Manage Cases',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 580,
                            child: Scrollbar(
                              thumbVisibility: true, //always show scrollbar
                              thickness: 3, //width of scrollbar
                              scrollbarOrientation: ScrollbarOrientation.right,
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: _caseModel!
                                      .map((singleCase) =>
                                          caseListCard(singleCase, context))
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
