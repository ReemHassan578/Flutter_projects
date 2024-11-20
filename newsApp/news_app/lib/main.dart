import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/home_layout.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import 'shared/bloc_observer.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = PostHttpOverrides();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? savedTheme = CacheHelper.getBoolean('isDark');

  runApp(MyApp(savedTheme));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusinessData()
        ..changeThemeMode(isDarkFromSP: isDark),
      child: BlocConsumer<NewsCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = NewsCubit.get(context);
          return MaterialApp(
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData(
              progressIndicatorTheme:
                  const ProgressIndicatorThemeData(color: Colors.deepOrange),
              // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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
            ),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
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
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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
            ),
            home: const Directionality(
                textDirection: TextDirection.ltr, child: HomeScreen()),
          );
        },
      ),
    );
  }
}


// https://newsapi.org/v2/top-headlines/?country=us&category=business&apiKey=bb3cd198fd96432cad3d9b18df23e4a0

// https://newsapi.org/v2/everything?q=tesla&from=2024-10-19&sortBy=publishedAt&apiKey=bb3cd198fd96432cad3d9b18df23e4a0