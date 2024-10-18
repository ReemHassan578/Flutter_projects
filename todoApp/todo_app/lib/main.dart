import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/theme_service.dart';
import 'package:todo_app/ui/screens/notification.dart';
import 'package:todo_app/ui/theme.dart';

import 'ui/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeService().theme,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        home: const Home()
        // NotificationScreen(payload: 'title|description|date'),
        );
  }
}
