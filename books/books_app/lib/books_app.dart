import 'package:books_app/core/routing/app_router.dart';
import 'package:books_app/core/theming/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routing/routes.dart';

class BooksApp extends StatelessWidget {
  final AppRouter router;
  const BooksApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: MyColors.backGroundColor,
          appBarTheme: AppBarTheme(
            color: MyColors.backGroundColor,
            //   actionsIconTheme: IconThemeData(color: Colors.white),
          ),
          textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
          iconButtonTheme: IconButtonThemeData(
              style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.4))),
          //   iconTheme: IconThemeData(color: Colors.white.withOpacity(0.2)),
          colorScheme: ColorScheme.dark(primary: Colors.white),

          // useMaterial3: true,
        ),
        onGenerateRoute: router.router,
        initialRoute: Routes.homeScreen,
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> sliderAnimation;
  Offset offset = Offset(0, 0);
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          SlideTransition(
            position: sliderAnimation,
            child: Text(
              'books boksdfgh',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    sliderAnimation = Tween(begin: Offset(0, 40.h), end: Offset(0, 0))
        .animate(animationController);
    animationController.forward();
  }
}
