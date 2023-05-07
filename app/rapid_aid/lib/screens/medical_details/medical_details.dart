import 'package:flutter/material.dart';
import 'package:rapid_aid/controllers/medical_controller.dart';
import 'package:rapid_aid/models/medical_model.dart';
import 'package:rapid_aid/widgets/header.dart';
import 'package:rapid_aid/widgets/medical_card.dart';

class MedicalDetails extends StatefulWidget {
  const MedicalDetails({super.key});

  @override
  State<MedicalDetails> createState() => _MedicalDetailsState();
}

class _MedicalDetailsState extends State<MedicalDetails> {
  bool _underTreatments = false;

  final _medicalFormKey = GlobalKey<FormState>();

  final _diseaseFormController = TextEditingController();
  final _sinceWhenFormController = TextEditingController();

  List<MedicalModel>? _medicalModel = [];

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _diseaseFormController.dispose();
    _sinceWhenFormController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getMedicals(); // Get user data
    });
  }

  // Get user data
  void _getMedicals() async {
    _medicalModel = (await MedicalController().getMedicals(context: context));
    setState(() {});
  }

  Future<void> _selectSinceWhen(BuildContext context) async {
    final DateTime? dobPicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960, 1),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF03045E), // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Color(0xFF03045E), // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFE01E37), // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (dobPicked != null) {
      setState(() {
        _sinceWhenFormController.text =
            dobPicked.toLocal().toString().split(' ')[0];
      });
    }
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
                    'Medical Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  Form(
                    key: _medicalFormKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: _diseaseFormController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF03045E),
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Disease / Allergy',
                            prefixIcon: Icon(Icons.coronavirus),
                            prefixIconColor: Colors.black,
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: _sinceWhenFormController,
                          readOnly: true,
                          onTap: () {
                            _selectSinceWhen(context);
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF03045E),
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Since When?',
                            hintText: "1999-01-01",
                            prefixIcon: Icon(Icons.date_range),
                            prefixIconColor: Colors.black,
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "* Required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(Icons.medication),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text('Under\nTreatments?'),
                            Expanded(
                              child: RadioListTile(
                                  title: const Text('Yes'),
                                  value: true,
                                  groupValue: _underTreatments,
                                  activeColor: const Color(0xFF03045E),
                                  onChanged: (value) {
                                    setState(() {
                                      _underTreatments = value!;
                                    });
                                  }),
                            ),
                            Expanded(
                              child: RadioListTile(
                                  title: const Text('No'),
                                  value: false,
                                  groupValue: _underTreatments,
                                  activeColor: const Color(0xFF03045E),
                                  onChanged: (value) {
                                    setState(() {
                                      _underTreatments = value!;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            // Navigate to the login screen
                            onPressed: () async {
                              if (_medicalFormKey.currentState!.validate()) {
                                await MedicalController().addMedical(
                                  context: context,
                                  disease: _diseaseFormController.text,
                                  since: _sinceWhenFormController.text,
                                  underTreatments: _underTreatments,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE01E37),
                            ),
                            child: const Text('Add'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: 330,
                              child: Scrollbar(
                                thumbVisibility: true, //always show scrollbar
                                thickness: 3, //width of scrollbar
                                scrollbarOrientation:
                                    ScrollbarOrientation.right,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: _medicalModel!
                                        .map((medical) =>
                                            medicalCard(medical, context))
                                        .toList(),
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
