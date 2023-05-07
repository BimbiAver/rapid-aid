import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:rapid_aid/config.dart';
import 'package:rapid_aid/utils/secure_storage.dart';

class UserApiService {
  // Create an instance of SecureStorge class
  final _secureStorage = SecureStorage();

  Future getUser(String userId) async {
    try {
      // API
      var url = Uri.parse('${Config.user}/$userId');
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

  Future updateUser(String userId, String userModelJson) async {
    try {
      // API
      var url = Uri.parse('${Config.user}/$userId');
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
        body: userModelJson,
      );

      // Return the response
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}
