import 'package:appointmentapp/features/splash/presentation/screens/splash.dart';
import 'package:flutter/material.dart';

import '../../features/login/presentation/screens/login.dart';
import '../../features/onboarding/presentation/screens/onboarding.dart';
import 'routes.dart';

class AppRouter {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const OnBoardingScreen();
          },
        );
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: Text('no route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
