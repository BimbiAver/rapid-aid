import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rapid_aid/models/case_model.dart';

Widget caseListCard(CaseModel singleCase, var context) {
  // Convert DateTime String into a DateTime object and format it
  DateTime dateTime = DateTime.parse(singleCase.dateTime.toString());
  final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  final String formatted = formatter.format(dateTime);

  Color? statusBgColour;
  Color? statusFontColour;

  // Set colours for the status chip
  if (singleCase.status == 'New') {
    statusBgColour = const Color(0xFFE01E37);
    statusFontColour = Colors.white;
  } else if (singleCase.status == 'Assigned' ||
      singleCase.status == 'Partially Assigned') {
    statusBgColour = Colors.yellow;
    statusFontColour = Colors.black;
  } else if (singleCase.status == 'Resolved') {
    statusBgColour = Colors.green;
    statusFontColour = Colors.white;
  } else {
    statusBgColour = Colors.black;
    statusFontColour = Colors.white;
  }

  return Container(
    margin: const EdgeInsets.only(top: 5),
    child: Card(
      color: const Color(0xFFF2F5FF),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                leading: const Icon(Icons.file_copy),
                title: Text(
                  formatted,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 2,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Status: ',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                        Chip(
                          visualDensity: VisualDensity.compact,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: statusBgColour,
                          label: Text(
                            '${singleCase.status}',
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
                    Text(
                      'Situation: ${singleCase.situation}',
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/view_case', arguments: {
                      'caseId': singleCase.id,
                    });
                  },
                  child: const Icon(
                    Icons.open_in_new,
                    color: Color(0xFF03045E),
                  ),
                ),
                const SizedBox(width: 3),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
