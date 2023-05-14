import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rapid_aid/controllers/case_controller.dart';
import 'package:rapid_aid/models/case_model.dart';
import 'package:rapid_aid/utils/handle_location_permissions.dart';
import 'package:rapid_aid/utils/manage_images.dart';
import 'package:rapid_aid/widgets/header.dart';

class CaseDetails extends StatefulWidget {
  const CaseDetails({super.key});

  @override
  State<CaseDetails> createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails> {
  late String _dateTime = '';
  late String _location = '';
  late String _situation = '';
  late String _department = '';

  String _imageCount = 'Browse';

  late CaseModel caseModel;

  // Store data coming from the previous screen
  Map data = {};

  List _images = [];

  final _detailsFormController = TextEditingController();

  // Set DateTime
  void _setDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    setState(() {
      _dateTime = formatter.format(now.toLocal());
    });
  }

  // Set location
  void _setLocation() async {
    // Handle location permissions
    final _hasPermission =
        await HandleLocationPermissions().handleLocationPermissions(context);

    if (_hasPermission) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _location = '${position.latitude}, ${position.longitude}';
      });
    }
  }

  // Set data
  void _setData() {
    setState(() {
      _setDateTime(); // Set DateTime
      _setLocation(); // Fetch and set location
      _situation = caseModel.situation!; // Set situation
      _department = _getDepartment();
    });
    // Save data to the model
    caseModel.dateTime = _dateTime;
    caseModel.location = _location;
    caseModel.details = _detailsFormController.text;
    caseModel.images = _images.cast<String>();
  }

  String _getDepartment() {
    String department = '';
    if (caseModel.departments?.police?.assign == true) {
      department += 'Police, ';
    }
    if (caseModel.departments?.hospital?.assign == true) {
      department += 'Hospital, ';
    }
    if (caseModel.departments?.fireBrigade?.assign == true) {
      department += 'Fire Brigade, ';
    }
    if (caseModel.departments?.dmc?.assign == true) {
      department += 'DMC, ';
    }
    if (caseModel.departments?.mwca?.assign == true) {
      department += 'MWCA, ';
    }
    return department.substring(0, department.length - 2);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      caseModel = data['caseModel']; // Assign arguments
      _setData(); // Set data
    });
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _detailsFormController.dispose();
    super.dispose();
  }

  // Browse images
  void _browseImages() async {
    _images = await ManageImages().browseImage() as List;
    setState(() {
      _imageCount = '${_images.length} selected';
    });
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
                    height: 50,
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
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
                              Text(_dateTime),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
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
                              Expanded(
                                child: TextField(
                                  minLines: 1,
                                  maxLines: 3,
                                  controller: _detailsFormController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration(
                                    isCollapsed: true,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(5, 10, 5, 10),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFF03045E),
                                        width: 1,
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    hintText: "More details",
                                    labelStyle: TextStyle(color: Colors.black),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
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
                          Row(
                            children: [
                              const Text(
                                'Image(s):',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _browseImages();
                                },
                                child: Chip(
                                  visualDensity: VisualDensity.compact,
                                  label: Text(_imageCount),
                                  deleteIcon: const Icon(
                                    Icons.delete,
                                    size: 20,
                                  ),
                                  onDeleted: () {
                                    _images.clear();
                                    setState(() {
                                      _imageCount = 'Browse';
                                    });
                                  },
                                ),
                              ),
                            ],
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
                      onPressed: () async {
                        _setData(); // Save data to the model
                        await CaseController().addCase(
                          context: context,
                          caseModel: caseModel,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE01E37),
                      ),
                      child: const Text('Submit'),
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
