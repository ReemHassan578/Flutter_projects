import 'package:books_app/core/di/dependeny_injection.dart';
import 'package:books_app/core/routing/routes.dart';
import 'package:books_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:books_app/features/search/presentation/views/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/presentation/views/screens/details_screen.dart';
import '../../features/home/presentation/views/screens/home_screen.dart';

class AppRouter {
  Route<dynamic>? router(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>getIt<HomeCubit>()..fetchAllBook(0),
            child: HomeScreen(),
          ),
        );
      case Routes.detailsScreen:
        return MaterialPageRoute(
          builder: (context) => DetailsScreen(),
        );
      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (context) => SearchScreen(),
        );
      default:
        return null;
    }
  }
}
