import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'business_logic/cubit/cubit/movies_cubit.dart';
import 'core/constants/my_colors.dart';
import 'data/repository/movies_repo.dart';
import 'data/web_services/api_helper/api_package.dart';
import 'data/web_services/movies_web_service.dart';
import 'presentation/screens/movies_screen.dart';

import 'data/models/movie.dart';
import 'presentation/screens/movie_details_screen.dart';
import 'core/constants/strings.dart';

class AppRouter {
  late MoviesCubit moviesCubit;
  late MoviesRepo moviesRepo;
  late MoviesWebService moviesWebService;

  AppRouter() {
    moviesWebService = MoviesWebService(apiPackage: dioPackge);
    moviesRepo = MoviesRepo(moviesWebService);
    moviesCubit = MoviesCubit(moviesRepo)..getAllMovies();
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case moviesScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => moviesCubit,
            child: OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  final bool connected =
                      connectivity != ConnectivityResult.none;
                  if (connected) {
                    return child;
                  }
                  return const OfflineScreen();
                },
                child: const MoviesScreen()),
          ),
        );
      case moviesDetailsScreen:
        final Movie movie = settings.arguments as Movie;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: moviesCubit,
            child: OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                final bool connected = connectivity != ConnectivityResult.none;
                if (connected) {
                  return child;
                }
                return const OfflineScreen();
              },
              child: MovieDetailsScreen(
                movie: movie,
              ),
            ),
          ),
        );
    }
    return null;
  }
}

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              fit: BoxFit.cover,
              'assets/images/offline.png',
              height: 400,
              width: 700,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Can\'t connect! Check Internet',
              style: TextStyle(
                fontSize: 20,
                color: MyColors.myYellow,
              ),
            )
          ],
        ),
      ),
    );
  }
}
