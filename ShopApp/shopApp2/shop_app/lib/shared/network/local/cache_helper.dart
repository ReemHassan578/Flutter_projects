import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late final SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, dynamic value}) async {
    if (value is int) {
      return prefs.setInt(key, value);
    }
    if (value is String) {
      return prefs.setString(key, value);
    }
    if (value is bool) {
      return prefs.setBool(key, value);
    } else {
      return prefs.setDouble(key, value);
    }
  }

  static Future<bool> removeData(String key) async {
    return await prefs.remove(key);
  }

  static dynamic getData(String key) {
    return prefs.get(key);
  }
}
