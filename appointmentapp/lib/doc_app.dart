import 'package:appointmentapp/core/helpers/constants.dart';
import 'package:appointmentapp/core/routing/app_router.dart';
import 'package:appointmentapp/core/routing/routes.dart';
import 'package:appointmentapp/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocApp extends StatelessWidget {
  final AppRouter appRouter;

  const DocApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        initialRoute: isUserLogin ?Routes.homeScreen : Routes.onBoardingScreen,
        onGenerateRoute: appRouter.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:const ColorScheme.light(primary: MyColors.bluePrimaryColor),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
      ),
    );
  }
}
