import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rapid_aid/models/case_model.dart';
import 'package:rapid_aid/services/case_api_service.dart';
import 'package:rapid_aid/utils/secure_storage.dart';

class CaseController {
  // Create an instance of SecureStorge class
  final _secureStorage = SecureStorage();

  Future addCase(
      {required var context,
      required CaseModel? caseModel,
      bool mounted = true}) async {
    try {
      // Add UserId to the model
      caseModel?.user = await _secureStorage.getUserId();
      // Set case status
      caseModel?.status = 'New';

      // Display the loading dialog
      showDialog(
        // The user CANNOT close this dialog by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      );

      Response response = await CaseApiService()
          .addCase(caseModelToJson(caseModel!)) as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // Check the response and do the needful
      if (response.statusCode == 201) {
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', (Route<dynamic> route) => false);
        // Show successful message
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your case has been reported successfully!'),
          ),
        );
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['error']),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future getCases({required var context, bool mounted = true}) async {
    try {
      // Display the loading dialog
      showDialog(
        // The user CANNOT close this dialog by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      );

      // Get medical data
      Response response = await CaseApiService().getCases() as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // Check the response and do the needful
      if (response.statusCode == 200) {
        // Convert JSON to a MedicalModel and return the response
        List<CaseModel> _medicalModel = caseModelListFromJson(response.body);
        return _medicalModel;
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error'),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future getCase(
      {required var context, required var caseId, bool mounted = true}) async {
    try {
      // Display the loading dialog
      showDialog(
        // The user CANNOT close this dialog by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      );

      // Get case data
      Response response =
          await CaseApiService().getCase(caseId) as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // Check the response and do the needful
      if (response.statusCode == 200) {
        // Convert JSON to a CaseModel and return the response
        CaseModel _caseModel = caseModelFromJson(response.body);
        return _caseModel;
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['error']),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
