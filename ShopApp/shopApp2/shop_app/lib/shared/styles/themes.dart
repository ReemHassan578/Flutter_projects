import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: defaultColor),
  fontFamily: 'Jannah',
  colorScheme: const ColorScheme.light(primary: defaultColor),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  ),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
    color: Colors.white,
    actionsIconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
      shape: CircleBorder(),
      foregroundColor: Colors.white),
);

ThemeData darkTheme = ThemeData(
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: defaultColor),
  colorScheme: const ColorScheme.dark(primary: defaultColor),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
      shape: CircleBorder(),
      foregroundColor: Colors.white),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
    color: grey,
    actionsIconTheme: const IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: grey,
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
  ),
  fontFamily: 'Jannah',
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: grey,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
  scaffoldBackgroundColor: grey,
);
