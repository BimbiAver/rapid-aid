import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:rapid_aid/config.dart';

class UserAuthApiService {
  Future login(String? emailAddress, String? mobileNo) async {
    try {
      // API
      var url = Uri.parse(Config.userLogin);
      // HTTP response
      http.Response response;

      // Check the login method and send HTTP POST request
      if (emailAddress != null && emailAddress.isNotEmpty) {
        Map data = {'emailAddress': emailAddress};
        // Encode Map to JSON
        var body = json.encode(data);
        response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: body,
        );
      } else {
        Map data = {'mobileNo': mobileNo};
        // Encode Map to JSON
        var body = json.encode(data);
        response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: body,
        );
      }

      // Return the response
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future verify(String? emailOrMobile, String? otp) async {
    try {
      // API
      var url = Uri.parse(Config.verifyOTP);
      // HTTP response
      http.Response response;

      // Send HTTP POST request
      Map data = {'emailOrMobile': emailOrMobile, 'otp': otp};
      // Encode Map to JSON
      var body = json.encode(data);
      response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      // Return the response
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future register(String userModelJson) async {
    try {
      // API
      var url = Uri.parse(Config.userRegister);
      // HTTP response
      http.Response response;

      // Send HTTP POST request
      response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: userModelJson,
      );

      // Return the response
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
