import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rapid_aid/models/user_model.dart';
import 'package:rapid_aid/services/user_api_service.dart';
import 'package:rapid_aid/utils/secure_storage.dart';

class UserController {
  // Create an instance of SecureStorge class
  final _secureStorage = SecureStorage();

  Future getUser({required var context, bool mounted = true}) async {
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

      // Get user data
      Response response = await UserApiService()
          .getUser('${await _secureStorage.getUserId()}') as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // Check the response and do the needful
      if (response.statusCode == 200) {
        // Convert JSON to a UserModel and return the response
        UserModel _userModel = userModelFromJson(response.body);
        return _userModel;
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

  Future updateUser(
      {required var context,
      required String? nicNo,
      required String? firstName,
      required String? lastName,
      required String? gender,
      required String? dob,
      required String? address,
      required String? mobileNo,
      required String? emailAddress,
      required String? bloodGroup,
      required String? guardianNicNo,
      required String? guardianFullName,
      required String? guardianAddress,
      required String? guardianContactNo,
      required String? relationship,
      bool mounted = true}) async {
    try {
      // Add +94 to the mobile no
      mobileNo = '+94$mobileNo';
      guardianContactNo = '+94$guardianContactNo';

      // Instantiate the Guradian
      var guardian = Guardian(
        nicNo: guardianNicNo,
        fullName: guardianFullName,
        address: guardianAddress,
        contactNo: guardianContactNo,
        relationship: relationship,
      );

      // Instantiate the UserModel
      var userModel = UserModel(
        id: '${await _secureStorage.getUserId()}',
        active: true,
        nicNo: nicNo,
        firstName: firstName,
        lastName: lastName,
        gender: gender,
        dob: dob,
        address: address,
        mobileNo: mobileNo,
        emailAddress: emailAddress,
        bloodGroup: bloodGroup,
        guardian: guardian,
      );

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

      Response response = await UserApiService().updateUser(
              '${await _secureStorage.getUserId()}', userModelToJson(userModel))
          as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // Check the response and do the needful
      if (response.statusCode == 200) {
        Navigator.pop(context);
        // Show successful message
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
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
}
