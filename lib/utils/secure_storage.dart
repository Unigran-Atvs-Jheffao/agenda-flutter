import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static FlutterSecureStorage secStorage = const FlutterSecureStorage();
  static Future<bool> hasTokenSet() async  {
    return secStorage.containsKey(key: "user");
  }

  static void setToken(token) async {
    secStorage.write(key: "user", value: token);
  }

  static Future<String?> getToken(token) async {
    return secStorage.read(key: "user");
  }
}