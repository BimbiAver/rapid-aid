import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rapid_aid/models/medical_model.dart';
import 'package:rapid_aid/services/medical_api_service.dart';
import 'package:rapid_aid/utils/secure_storage.dart';

class MedicalController {
  // Create an instance of SecureStorge class
  final _secureStorage = SecureStorage();

  Future addMedical(
      {required var context,
      required String? disease,
      required String? since,
      required bool? underTreatments,
      bool mounted = true}) async {
    try {
      // Instantiate the MedicalModel
      var medicalModel = MedicalModel(
          disease: disease, since: since, underTreatments: underTreatments);

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

      Response response = await MedicalApiService().addMedical(
          '${await _secureStorage.getUserId()}',
          medicalModelToJson(medicalModel)) as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // Check the response and do the needful
      if (response.statusCode == 201) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/medical_details');
        // Show successful message
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Medical detail added successfully!'),
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

  Future getMedicals({required var context, bool mounted = true}) async {
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
      Response response = await MedicalApiService()
          .getMedicals('${await _secureStorage.getUserId()}') as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // New encoded JSON data
      var newData = jsonEncode(data['medicalDetails']);

      // Check the response and do the needful
      if (response.statusCode == 200) {
        // Convert JSON to a MedicalModel and return the response
        List<MedicalModel> _medicalModel = medicalModelListFromJson(newData);
        return _medicalModel;
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

  Future deleteMedical(
      {required var context,
      required var medicalId,
      bool mounted = true}) async {
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
      Response response = await MedicalApiService().deleteMedical(
          '${await _secureStorage.getUserId()}', medicalId) as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // Check the response and do the needful
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushNamed(context, '/medical_details');
        // Show successful message
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
          ),
        );
      } else {
        Navigator.pop(context);
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
