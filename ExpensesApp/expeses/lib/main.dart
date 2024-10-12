import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home.dart';

ColorScheme colorscheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 2, 24, 39));

ColorScheme darkcolorscheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 2, 24, 39));
void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
  //   (value) =>
  runApp(const MyApp());
  //,
  //);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: ThemeData().copyWith(
        colorScheme: colorscheme,
        useMaterial3: true,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: colorscheme.onPrimaryContainer,
            foregroundColor: colorscheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: colorscheme.secondaryContainer,
          margin: const EdgeInsets.all(2),
        ),
        bottomSheetTheme: const BottomSheetThemeData().copyWith(
          backgroundColor: colorscheme.primaryContainer,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: colorscheme.primary),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: colorscheme.tertiary,
                fontSize: 20,
              ),
            ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: darkcolorscheme,
        useMaterial3: true,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: darkcolorscheme.onPrimaryContainer,
            foregroundColor: darkcolorscheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
          color: darkcolorscheme.secondaryContainer,
          margin: const EdgeInsets.all(2),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: darkcolorscheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: darkcolorscheme.tertiary,
                fontSize: 20,
              ),
            ),
      ),
      home: const Home(),
    );
  }
}
