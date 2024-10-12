import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme().copyWith(
            headlineMedium: const TextStyle(
          color: Colors.white,
        )),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0, 121, 107, 1)),
      ),
      home: const Home(),
    );
  }
}
