import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/layout_Screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'modules/onboarding/onboarding_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isOnBoardingShown = CacheHelper.getData('onBoardingShown');
  bool? isDark = CacheHelper.getData('isDark');
  token = CacheHelper.getData('token');
  Widget page = OnBoardingScreen();
  if (isOnBoardingShown != null) {
    if (token != null) {
      page = const HomeScreen();
    } else {
      page = LoginScreen();
    }
  }
  runApp(MyApp(isDark: isDark, page: page));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.page, required this.isDark, super.key});
  final Widget page;
  final bool? isDark;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..changeThemeMode(isDarkFromCache: isDark)
        ..getHomeProduct()
        ..getCategories(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              //AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: page);
        },
      ),
    );
  }
}
