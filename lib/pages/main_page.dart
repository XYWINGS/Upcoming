//Packages
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/controllers/main_page_data_controller.dart';
//Models
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/movie_tile.dart';
import 'package:movie_app/models/category_selection.dart';
import 'package:movie_app/models/main_page_data.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>((ref) {
      return MainPageDataController();
    });

final selectedMoviePosterURLProvider = StateProvider<String>((ref) {
  final movie = ref.watch(mainPageDataControllerProvider).movies;
  return movie.isNotEmpty ? movie[0].posterUrl() : '';
});

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  late MainPageDataController mainPageDataController;
  late MainPageData mainPageData;
  late String backgroundMoviePosterURL;

  late TextEditingController searchTextFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    searchTextFieldController = TextEditingController();
    searchTextFieldController.text = ref
        .watch(mainPageDataControllerProvider)
        .searchQuery;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    backgroundMoviePosterURL = ref.watch(selectedMoviePosterURLProvider);
    mainPageDataController = ref.watch(mainPageDataControllerProvider.notifier);
    mainPageData = ref.watch(mainPageDataControllerProvider);
    return _buildUI(screenWidth, screenHeight, ref);
  }

  Widget _buildUI(double screenWidth, double screenHeight, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Center(
          child: Stack(
            children: [
              backgroundWidget(screenWidth, screenHeight),
              foreGroundWidget(screenWidth, screenHeight, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget backgroundWidget(double screenWidth, double screenHeight) {
    if (backgroundMoviePosterURL.isEmpty) {
      return Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.black,
      );
    } else {
      return Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(backgroundMoviePosterURL),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ),
        ),
      );
    }
  }

  Widget foreGroundWidget(
    double screenWidth,
    double screenHeight,
    WidgetRef ref,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        screenWidth * 0.05,
        screenHeight * 0.05,
        screenWidth * 0.05,
        0,
      ),
      width: screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          topBarWidget(screenWidth, screenHeight),
          Container(
            height: screenHeight * 0.80,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
            child: movieListViewWidget(screenWidth, screenHeight, ref),
          ),
        ],
      ),
    );
  }

  Widget topBarWidget(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          searchFieldWidget(screenWidth, screenHeight),
          categorySelectionWidget(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Widget searchFieldWidget(double screenWidth, double screenHeight) {
    final border = InputBorder.none;
    return SizedBox(
      width: screenWidth * 0.50,
      height: screenHeight * 0.05,
      child: TextField(
        controller: searchTextFieldController,
        onSubmitted: (input) => {
          mainPageDataController.updateSearchQuery(input),
        },
        style: TextStyle(color: Colors.white, fontSize: 16.0),
        decoration: InputDecoration(
          focusedBorder: border,
          border: border,
          prefixIcon: Icon(Icons.search, color: Colors.white24),
          hintStyle: TextStyle(color: Colors.white24, fontSize: 16.0),
          hintText: 'Search',
          filled: false,
          fillColor: Colors.white24,
        ),
      ),
    );
  }

  Widget categorySelectionWidget(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.30,
      height: screenHeight * 0.05,
      child: DropdownButton<String>(
        value: mainPageData.searchCategory,
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        items: [
          DropdownMenuItem<String>(
            value: SearchCategory.popular,
            child: Text(
              SearchCategory.popular,
              style: TextStyle(color: Colors.white),
            ),
          ),
          DropdownMenuItem<String>(
            value: SearchCategory.upcoming,
            child: Text(
              SearchCategory.upcoming,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        onChanged: (dropDownValue) => dropDownValue.toString().isNotEmpty
            ? mainPageDataController.updateSearchCategory(dropDownValue!)
            : '',
        dropdownColor: Colors.black.withValues(alpha: 0.5),
        underline: Container(),
      ),
    );
  }

  Widget movieListViewWidget(
    double screenWidth,
    double screenHeight,
    WidgetRef ref,
  ) {
    final List<Movie> movies = mainPageData.movies;

    if (movies.isEmpty) {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white54),
      );
    } else {
      return NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification) {
            final before = notification.metrics.extentBefore;
            final max = notification.metrics.maxScrollExtent;
            if (before == max) {
              mainPageDataController.getMovies();
              return true;
            }
            return false;
          }
          return false;
        },
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int count) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: GestureDetector(
                onTap: () {
                  ref.read(selectedMoviePosterURLProvider.notifier).state =
                      movies[count].posterUrl();
                },
                child: MovieTile(
                  height: screenHeight * 0.3,
                  width: screenWidth * 0.85,
                  movie: movies[count],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
