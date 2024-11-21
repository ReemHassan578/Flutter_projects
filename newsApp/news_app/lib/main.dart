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
import 'shared/styles/styles.dart';

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
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
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