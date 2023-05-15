import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:rapid_aid/config.dart';
import 'package:rapid_aid/utils/secure_storage.dart';

class CaseApiService {
  // Create an instance of SecureStorge class
  final _secureStorage = SecureStorage();

  Future addCase(String caseModelJson) async {
    try {
      // API
      var url = Uri.parse(Config.cases);
      // HTTP response
      http.Response response;

      // Send HTTP GET request
      response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await _secureStorage.getToken()}',
        },
        body: caseModelJson,
      );

      // Return the response
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future getCases() async {
    try {
      // API
      var url = Uri.parse(Config.cases);
      // HTTP response
      http.Response response;

      // Send HTTP GET request
      response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await _secureStorage.getToken()}',
        },
      );

      // Return the response
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future getCase(String caseId) async {
    try {
      // API
      var url = Uri.parse('${Config.cases}/$caseId');
      // HTTP response
      http.Response response;

      // Send HTTP GET request
      response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await _secureStorage.getToken()}',
        },
      );

      // Return the response
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future cancelCase(String caseId) async {
    try {
      // API
      var url = Uri.parse('${Config.cases}/$caseId');
      // HTTP response
      http.Response response;

      // Send HTTP GET request
      response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await _secureStorage.getToken()}',
        },
        body: json.encode({'status': 'Cancelled'}),
      );

      // Return the response
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
