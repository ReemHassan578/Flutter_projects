import '../models/movie.dart';

import '../web_services/movies_web_service.dart';

class MoviesRepo {
  final MoviesWebService moviesWebService;
  MoviesRepo(this.moviesWebService);

  Future<List<Movie>?> getMovies() async {
    try {
      List<Movie> movies = [];
      List? data = await moviesWebService.getMovies();

      if (data == null) {
        return null;
      }
      for (final i in data) {
        movies.add(Movie.fromJson(i));
      }
      return movies;
    } catch (error) {
      return null;
    }
  }
}
