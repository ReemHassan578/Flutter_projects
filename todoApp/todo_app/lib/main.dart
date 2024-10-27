import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/services/theme_service.dart';
import 'package:todo_app/ui/theme.dart';

import 'services/notification_service.dart';
import 'ui/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await GetStorage.init();
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
