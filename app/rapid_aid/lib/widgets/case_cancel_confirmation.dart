import 'package:flutter/material.dart';
import 'package:rapid_aid/controllers/case_controller.dart';

class CaseCancelConfirmation {
  caseCancelConfirmationAlertDialog(BuildContext context, String caseId) {
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
        // Cancel the case
        await CaseController().cancelCase(context: context, caseId: caseId);
      },
    );
    // AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text('Confirm'),
      content: const Text('Are you sure you want to cancel this case?'),
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
