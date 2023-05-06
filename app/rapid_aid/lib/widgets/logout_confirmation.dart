import 'package:flutter/material.dart';
import 'package:rapid_aid/utils/secure_storage.dart';

class LogoutConfirmation {
  // Create an instance of SecureStorge class
  final _secureStorage = SecureStorage();

  logoutConfirmationAlertDialog(BuildContext context) {
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
        // Clear the SecureStorage (Token) - Logout
        await _secureStorage.deleteStorage();
        // Navigate to the Login screen
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', (Route<dynamic> route) => false);
      },
    );
    // AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text('Confirm'),
      content: const Text('Are you sure you want to logout?'),
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
