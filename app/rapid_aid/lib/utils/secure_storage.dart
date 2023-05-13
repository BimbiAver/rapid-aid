import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final String _keyToken = 'token';
  final String _keyUserId = 'userId';

  // Create storage
  final storage = const FlutterSecureStorage();

  // Delete storage
  Future deleteStorage() async {
    await storage.deleteAll();
  }

  // Set JWT
  Future setToken(String token) async {
    await storage.write(key: _keyToken, value: token);
  }

  // Get JWT
  Future<String?> getToken() async {
    return await storage.read(key: _keyToken);
  }

  // Set UserId
  Future setUserId(String userId) async {
    await storage.write(key: _keyUserId, value: userId);
  }

  // Get UserId
  Future<String?> getUserId() async {
    return await storage.read(key: _keyUserId);
  }
}
