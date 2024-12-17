import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'styles.dart';

ThemeData lightTheme = ThemeData(
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: defaultColor),
  colorScheme: const ColorScheme.light(primary: defaultColor),
  textTheme: TextTheme(
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelSmall: labelSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    headlineMedium: headlineMedium,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.w,
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w700),
    color: Colors.white,
    actionsIconTheme: const IconThemeData(color: Colors.black),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
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
    titleSpacing: 20.w,
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),
    color: grey,
    actionsIconTheme: const IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: grey,
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
  ),
  textTheme: TextTheme(
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelSmall: labelSmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    headlineMedium: headlineMedium,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    backgroundColor: grey,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
  scaffoldBackgroundColor: grey,
);
