// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutterapp/app_router.dart';
import 'package:flutterapp/core/shared/themes.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    super.key,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: appRouter.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
    );
  }
}

// MoviesWebService(apiPackage: dioPackge)