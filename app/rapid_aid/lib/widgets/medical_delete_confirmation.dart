import 'package:flutter/material.dart';
import 'package:rapid_aid/controllers/medical_controller.dart';

class MedicalDeleteConfirmation {
  medicalDeleteConfirmationAlertDialog(BuildContext context, String medicalId) {
    // Buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop(); // Dismiss the dialog
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () async {
        // Delete the medical
        await MedicalController()
            .deleteMedical(context: context, medicalId: medicalId);
      },
    );
    // AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text('Confirm'),
      content: const Text('Are you sure you want to delete this item?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
