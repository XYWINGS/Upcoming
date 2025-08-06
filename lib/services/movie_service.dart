//Packages
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/movie.dart';
//Services
import 'package:movie_app/services/http_service.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPService http;

  MovieService() {
    http = getIt.get<HTTPService>();
  }

  Future<List<Movie>> getPopularMovies({required int page}) async {
    Response response = await http.get(
      '/movie/popular',
      query: {'page': page.toString()},
    );
    List<Movie> movies = [];
    if (response.statusCode == 200) {
      movies = (response.data['results'] as List)
          .map<Movie>((movieData) => Movie.fromJson(movieData))
          .toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
    return movies;
  }
}
