import '../../core/constants/strings.dart';

import 'api_helper/api_package.dart';

class MoviesWebService {
  final ApiPackage apiPackage;

  MoviesWebService({required this.apiPackage});

  Future<List<dynamic>?> getMovies() async {
    try {
      return await apiPackage.get(moviesUrl);
    } catch (error) {
      return null;
    }
  }
}
