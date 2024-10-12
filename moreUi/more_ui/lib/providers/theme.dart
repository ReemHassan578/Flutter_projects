import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProvider extends StateNotifier<ThemeData> {
  ThemeProvider() : super(ThemeData.light());

  setDarkMode() {
    state = ThemeData.dark();
  }

  setLightMode() {
    state = ThemeData.light();
  }

  setScaffoldColor(Color color) {
    state = ThemeData(scaffoldBackgroundColor: color);
  }
}

final themeProvider = StateNotifierProvider<ThemeProvider, ThemeData>(
  (ref) {
    return ThemeProvider();
  },
);
