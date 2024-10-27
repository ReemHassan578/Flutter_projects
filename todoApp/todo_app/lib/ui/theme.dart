import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = Color.fromARGB(255, 162, 118, 170);
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryClr,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryClr,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25)),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: darkGreyClr,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: primaryClr,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25)));

  TextStyle get headingStyle {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 25,
      color: Get.isDarkMode ? Colors.white : darkGreyClr,
    );
  }

  TextStyle get subHeadingStyle {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Get.isDarkMode ? Colors.white : darkGreyClr,
    );
  }

  TextStyle get titleStyle {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Get.isDarkMode ? Colors.white : darkGreyClr,
    );
  }

  TextStyle get subTitleStyle {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Get.isDarkMode ? Colors.white : darkGreyClr,
    );
  }

  TextStyle get subTitleStyleGrey {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.grey,
    );
  }

  TextStyle get bodyStyle {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Get.isDarkMode ? Colors.white : darkGreyClr,
    );
  }

  TextStyle get body2Style {
    return TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Get.isDarkMode ? Colors.grey[200] : darkGreyClr,
    );
  }

  TextStyle get subTitleStyleWhite {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 10,
      color: Colors.white,
    );
  }
}
