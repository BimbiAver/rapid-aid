import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rapid_aid/models/user_model.dart';
import 'package:rapid_aid/services/user_auth_api_service.dart';
import 'package:rapid_aid/utils/secure_storage.dart';

class UserAuthController {
  Future login(
      {required var context,
      required String? emailAddress,
      required String? mobileNo,
      bool mounted = true}) async {
    try {
      // Add +94 to the mobile no
      mobileNo = '+94$mobileNo';

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

      Response response = await UserAuthApiService()
          .login(emailAddress, mobileNo) as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // Check the response and do the needful
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/otp_verification', arguments: {
          'emailOrMobile': emailAddress != null && emailAddress.isNotEmpty
              ? emailAddress
              : mobileNo,
        });
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

  Future verify(
      {required var context,
      required String? emailOrMobile,
      required String? otp,
      bool mounted = true}) async {
    // Create an instance of SecureStorge class
    final _secureStorage = SecureStorage();

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

      Response response = await UserAuthApiService().verify(emailOrMobile, otp)
          as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // Check the response and do the needful
      if (response.statusCode == 202) {
        // Clear SecureStorage
        await _secureStorage.deleteStorage();
        // Save Token & UserId on SecureStorage
        await _secureStorage.setToken(data['token']);
        await _secureStorage.setUserId(data['userId']);
        // Navigate to the Dashboard
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', (Route<dynamic> route) => false);
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

  Future register(
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

      Response response = await UserAuthApiService()
          .register(userModelToJson(userModel)) as http.Response;

      // Close the loading dialog automatically
      if (!mounted) return;
      Navigator.of(context).pop();

      // Decode the JSON response object
      var data = jsonDecode(response.body);

      // Check the response and do the needful
      if (response.statusCode == 201) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', (Route<dynamic> route) => false);
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: data['error'] != null
                ? Text(data['error'])
                : Text(data['message']),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
