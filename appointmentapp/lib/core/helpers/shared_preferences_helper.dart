import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();
  static late final SharedPreferences prefs;

  static initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future removeItem(String key) {
    return prefs.remove(key);
  }

  static int? getInt(String key) {
    return prefs.getInt(key);
  }

  static String? getString(String key) {
    return prefs.getString(key);
  }

  static double? getdouble(String key) {
    return prefs.getDouble(key);
  }

  static bool? getBool(String key) {
    return prefs.getBool(key);
  }

  static List<String>? getStringList(String key) {
    return prefs.getStringList(key);
  }

  static Future<bool> clearAllData() {
    return prefs.clear();
  }

  static Future? setData(key, value) {
    switch (value.runtimeType) {
      case const (int):
        return prefs.setInt(key, value);

      case const (double):
        return prefs.setDouble(key, value);

      case const (String):
        return prefs.setString(key, value);

      case const (bool):
        return prefs.setBool(key, value);

      case const (List<String>):
        return prefs.setStringList(key, value);

      default:
        return null;
    }
  }

  static Future<void> setSecuredString(String key, String value) {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final FlutterSecureStorage storage =
        FlutterSecureStorage(aOptions: getAndroidOptions());
    return storage.write(key: key, value: value);
  }

  static Future<String?> getSecuredString(String key) {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
    final FlutterSecureStorage storage =
        FlutterSecureStorage(aOptions: getAndroidOptions());
    return storage.read(key: key);
  }

  static Future clearAllSecuredData() {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );

    final FlutterSecureStorage storage =
        FlutterSecureStorage(aOptions: getAndroidOptions());

    return storage.deleteAll();
  }
}
