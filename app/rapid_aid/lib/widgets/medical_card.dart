import 'package:flutter/material.dart';
import 'package:rapid_aid/controllers/medical_controller.dart';
import 'package:rapid_aid/models/medical_model.dart';
import 'package:rapid_aid/widgets/medical_delete_confirmation.dart';

Widget medicalCard(MedicalModel medical, var context) {
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
              leading: const Icon(Icons.health_and_safety),
              title: Text(
                medical.disease.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  height: 2,
                ),
              ),
              subtitle: Text(
                'Since: ${medical.since.toString().substring(0, medical.since.toString().indexOf('T'))}\nUnder Treatments: Yes',
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    await MedicalDeleteConfirmation()
                        .medicalDeleteConfirmationAlertDialog(
                            context, medical.id.toString());
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Color(0xFFE01E37),
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
