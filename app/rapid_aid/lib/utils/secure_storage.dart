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

  Future setToken(String token) async {
    await storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _keyToken);
  }

  Future setUserId(String userId) async {
    await storage.write(key: _keyUserId, value: userId);
  }

  Future<String?> getUserId() async {
    return await storage.read(key: _keyUserId);
  }
}
