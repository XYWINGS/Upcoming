//Packages
import 'package:get_it/get_it.dart';
//Models
import 'package:movie_app/models/app_config.dart';

class Movie {
  final String name;
  final String language;
  final String description;
  final String posterPath;
  final String backdropUrl;
  final String releaseDate;
  final bool isAdult;
  final num rating;

  Movie({
    required this.name,
    required this.language,
    required this.description,
    required this.posterPath,
    required this.backdropUrl,
    required this.releaseDate,
    required this.isAdult,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['title'] as String,
      language: json['original_language'] as String,
      description: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      backdropUrl: json['backdrop_path'] as String,
      releaseDate: json['release_date'] as String,
      isAdult: json['adult'] as bool,
      rating: (json['vote_average'] ?? 0).toDouble(),
    );
  }

  String posterUrl() {
    final AppConfig config = GetIt.instance<AppConfig>();
    return '${config.baseImageApiUrl}$posterPath';
  }
}
