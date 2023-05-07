import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:rapid_aid/config.dart';
import 'package:rapid_aid/utils/secure_storage.dart';

class MedicalApiService {
  // Create an instance of SecureStorge class
  final _secureStorage = SecureStorage();

  Future addMedical(String userId, String medicalModelJson) async {
    try {
      // API
      var url = Uri.parse('${Config.medical}/$userId');
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
        body: medicalModelJson,
      );

      // Return the response
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future getMedicals(String userId) async {
    try {
      // API
      var url = Uri.parse('${Config.medical}/$userId');
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

  Future deleteMedical(String userId, String medicalId) async {
    try {
      // API
      var url = Uri.parse('${Config.medical}/$userId');
      // HTTP response
      http.Response response;

      Map data = {'medicalId': medicalId};
      // Encode Map to JSON
      var body = json.encode(data);

      // Send HTTP GET request
      response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await _secureStorage.getToken()}',
        },
        body: body,
      );

      // Return the response
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
