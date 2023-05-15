import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rapid_aid/controllers/case_controller.dart';
import 'package:rapid_aid/models/case_model.dart';
import 'package:rapid_aid/widgets/case_image.dart';
import 'package:rapid_aid/widgets/header.dart';

class ViewCase extends StatefulWidget {
  const ViewCase({super.key});

  @override
  State<ViewCase> createState() => _ViewCaseState();
}

class _ViewCaseState extends State<ViewCase> {
  // Store data coming from the previous screen
  Map data = {};

  late CaseModel _caseModel;

  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  String _formattedDateTime = '';
  String _status = '';
  String _situation = '';
  String _department = '';
  String _details = '';
  String _location = '';

  List<String> _images = [];

  Color? statusBgColour;
  Color? statusFontColour;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getCase(); // Get cases
    });
  }

  // Get case
  void _getCase() async {
    _caseModel = (await CaseController()
        .getCase(context: context, caseId: data['caseId'].toString()));
    _setData();
    setState(() {});
  }

  void _setData() {
    // Convert DateTime String into a DateTime object and format it
    DateTime dateTime = DateTime.parse(_caseModel.dateTime.toString());
    _formattedDateTime = formatter.format(dateTime);

    _status = _caseModel.status.toString();
    _situation = _caseModel.situation.toString();
    _details = _caseModel.details.toString();
    _location = _caseModel.location.toString();
    _images = _caseModel.images!;

    // Set colours for the status chip
    if (_caseModel.status == 'New') {
      statusBgColour = const Color(0xFFE01E37);
      statusFontColour = Colors.white;
    } else if (_caseModel.status == 'Assigned' ||
        _caseModel.status == 'Partially Assigned') {
      statusBgColour = Colors.yellow;
      statusFontColour = Colors.black;
    } else if (_caseModel.status == 'Resolved') {
      statusBgColour = Colors.green;
      statusFontColour = Colors.white;
    } else {
      statusBgColour = Colors.black;
      statusFontColour = Colors.white;
    }

    // Get department list
    if (_caseModel.departments?.police?.assign == true) {
      _department += 'Police, ';
    }
    if (_caseModel.departments?.hospital?.assign == true) {
      _department += 'Hospital, ';
    }
    if (_caseModel.departments?.fireBrigade?.assign == true) {
      _department += 'Fire Brigade, ';
    }
    if (_caseModel.departments?.dmc?.assign == true) {
      _department += 'DMC, ';
    }
    if (_caseModel.departments?.mwca?.assign == true) {
      _department += 'MWCA, ';
    }
    _department = _department.substring(0, _department.length - 2);
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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus
            ?.unfocus(), // Hide the soft keyboard
        child: Column(
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
                    'Case Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        height: _images.isNotEmpty ? 470 : null,
                        child: Scrollbar(
                          thumbVisibility: true, //always show scrollbar
                          thickness: 3, //width of scrollbar
                          scrollbarOrientation: ScrollbarOrientation.right,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Date & Time:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(_formattedDateTime),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Status: ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Chip(
                                      visualDensity: VisualDensity.compact,
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      backgroundColor: statusBgColour,
                                      label: Text(
                                        _status,
                                        style: TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.normal,
                                          color: statusFontColour,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(0),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Situation:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(_situation),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    runSpacing: 4.0,
                                    direction: Axis.horizontal,
                                    children: [
                                      const Text(
                                        'Department(s):',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(_department),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Details:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(_details),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Location:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(_location),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: _images
                                      .map((caseImage) =>
                                          caseImageList(caseImage))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
