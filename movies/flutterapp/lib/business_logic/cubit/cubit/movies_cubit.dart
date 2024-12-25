import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/movie.dart';
import '../../../data/repository/movies_repo.dart';

part 'movies_states.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesRepo moviesRepo;

  MoviesCubit(
    this.moviesRepo,
  ) : super(MoviesInitialState());

  static MoviesCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  List<Movie>? searchMovies;

  List<Movie>? movies;
  getAllMovies() {
    moviesRepo.getMovies().then((movies) {
      this.movies = movies;
      emit(GetMoviesSuccessState());
    }).catchError((error) {
      emit(ErrorState());
    });
  }

  searchForMovie(String typedText) {
    if (movies == null) return;
    searchMovies = movies!.where(
      (element) {
        return element.title.toLowerCase().startsWith(typedText.toLowerCase());
      },
    ).toList();
  }

  double opacity = 0;

  changeOpacity() {
    opacity = opacity == 0 ? 1 : 0;
    emit(ChangeOpacityState());
  }
}
