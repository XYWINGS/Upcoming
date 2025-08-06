import 'package:movie_app/models/movie.dart';

class MainPageData {
  final List<Movie> movies;
  final int page;
  final String searchCategory;
  final bool isLoading;
  final String searchQuery;

  MainPageData({
    required this.movies,
    required this.page,
    required this.searchCategory,
    required this.isLoading,
    required this.searchQuery,
  });

  MainPageData.initial()
    : movies = [],
      page = 1,
      searchCategory = 'popular',
      isLoading = false,
      searchQuery = '';

  MainPageData copyWith({
    List<Movie>? movies,
    int? page,
    String? searchCategory,
    bool? isLoading,
    String? searchQuery,
  }) {
    return MainPageData(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      searchCategory: searchCategory ?? this.searchCategory,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
