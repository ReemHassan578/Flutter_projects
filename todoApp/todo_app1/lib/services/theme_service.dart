import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  GetStorage box = GetStorage();
  final String _key = 'isDarkMode';

  ThemeMode get theme {
    return loadThemefromBox() ? ThemeMode.dark : ThemeMode.light;
  }

  bool loadThemefromBox() {
    return box.read<bool>(_key) ?? false;
  }

  void saveThemeToBox(bool isDarkMode) {
    box.write(_key, isDarkMode);
  }

  void switchTheme() {
    Get.changeThemeMode(loadThemefromBox() ? ThemeMode.light : ThemeMode.dark);
    //   Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(!loadThemefromBox());
  }
}
