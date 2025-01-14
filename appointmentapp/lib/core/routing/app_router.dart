import 'package:appointmentapp/core/di/dependency_injection.dart';
import 'package:appointmentapp/features/login/domain/cubit/login_cubit.dart';
import 'package:appointmentapp/features/signup/domain/cubit/register_cubit.dart';
import 'package:appointmentapp/features/signup/presentation/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: LoginScreen(),
            );
          },
        );
         case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => getIt<RegisterCubit>(),
              child: SignUpScreen(),
            );
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
