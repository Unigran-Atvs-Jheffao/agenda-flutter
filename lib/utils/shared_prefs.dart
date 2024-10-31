
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> hasTokenSet() async  {
    var sp = await SharedPreferences.getInstance();
    return sp.containsKey("user");
  }

  static void setToken(token) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString("user", token);
  }

  static Future<String?> getToken(token) async {
    var sp = await SharedPreferences.getInstance();
    return sp.getString("user");
  }
}