import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: Colors.deepOrange),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
);

ThemeData darkTheme = ThemeData(
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: Colors.deepOrange),
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    color: HexColor('333739'),
    actionsIconTheme: const IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: HexColor('333739'),
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
  scaffoldBackgroundColor: HexColor('333739'),
);
