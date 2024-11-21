import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late final SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static saveBoolen(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  static bool? getBoolen(String key) {
    return prefs.getBool(key);
  }
}
