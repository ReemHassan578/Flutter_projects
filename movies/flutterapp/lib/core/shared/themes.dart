import 'package:flutter/material.dart';
import '../constants/my_colors.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(primary: MyColors.myYellow),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: MyColors.myGrey),
        actionsIconTheme: IconThemeData(color: MyColors.myGrey),
        color: MyColors.myYellow,
        titleTextStyle: TextStyle(color: MyColors.myGrey, fontSize: 25)),
    scaffoldBackgroundColor: MyColors.myGrey);
