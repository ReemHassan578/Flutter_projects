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

  static dynamic get(String key) {}

  static bool? getBoolen(String key) {
    return prefs.getBool(key);
  }

  static String? getString(String key) {
    return prefs.getString(key);
  }

  static int? getInt(String key) {
    return prefs.getInt(key);
  }
}
