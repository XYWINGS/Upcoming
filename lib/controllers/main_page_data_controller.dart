//Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/category_selection.dart';
import 'package:movie_app/models/main_page_data.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/movie_service.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
    : super(state ?? MainPageData.initial()) {
    getMovies();
  }

  final MovieService movieService = GetIt.instance<MovieService>();

  Future<void> getMovies() async {
    state = state.copyWith(isLoading: true);
    try {
      List<Movie> movies = [];

      if (state.searchQuery.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          movies = await movieService.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.upcoming) {
          movies = await movieService.getUpcomingMovies(page: state.page);
        } else {
          movies = [];
        }
      } else {
        movies = await movieService.searchMoviesByName(state.searchQuery);
      }
      state = state.copyWith(
        movies: [...state.movies, ...movies],
        isLoading: false,
        page: state.page + 1,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception('Failed to get movies');
    }
  }

  void updateSearchQuery(String query) {
    try {
      state = state.copyWith(
        movies: [],
        searchCategory: SearchCategory.none,
        page: 1,
        searchQuery: query,
      );
      getMovies();
    } catch (e) {
      throw Exception('Error updating search query');
    }
  }

  void updateSearchCategory(String searchCategory) {
    try {
      state = state.copyWith(
        movies: [],
        searchCategory: searchCategory,
        page: 1,
        searchQuery: '',
      );
      getMovies();
    } catch (e) {
      throw Exception('Error updating search category');
    }
  }
}
