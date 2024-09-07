import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 123, 129, 214),
            surface: const Color.fromARGB(255, 44, 50, 60),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 49, 57, 59),
         
    appBarTheme: AppBarTheme(titleTextStyle: Theme.of(context).textTheme.titleLarge
    !.copyWith(color:Theme.of(context).colorScheme.primaryContainer)),
),
          
      home:  const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
