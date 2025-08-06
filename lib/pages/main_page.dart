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

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  late MainPageDataController mainPageDataController;
  late MainPageData mainPageData;

  final TextEditingController searchTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    mainPageDataController = ref.watch(mainPageDataControllerProvider.notifier);
    mainPageData = ref.watch(mainPageDataControllerProvider);
    return _buildUI(screenWidth, screenHeight);
  }

  Widget _buildUI(double screenWidth, double screenHeight) {
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
              foreGroundWidget(screenWidth, screenHeight),
            ],
          ),
        ),
      ),
    );
  }

  Widget backgroundWidget(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2)),
        ),
      ),
    );
  }

  Widget foreGroundWidget(double screenWidth, double screenHeight) {
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
            child: movieListViewWidget(screenWidth, screenHeight),
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
        onSubmitted: (input) {},
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
        value: SearchCategory.popular,
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
          DropdownMenuItem<String>(
            value: SearchCategory.none,
            child: Text(
              SearchCategory.none,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        onChanged: (String? newValue) {},
        dropdownColor: Colors.black.withValues(alpha: 0.5),
        underline: Container(),
      ),
    );
  }

  Widget movieListViewWidget(double screenWidth, double screenHeight) {
    final List<Movie> movies = mainPageData.movies;

    if (movies.isEmpty) {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white54),
      );
    } else {
      return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int count) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal: 0,
            ),
            child: GestureDetector(
              onTap: () => {},
              child: MovieTile(
                height: screenHeight * 0.50,
                width: screenWidth * 0.85,
                movie: movies[count],
              ),
            ),
          );
        },
      );
    }
  }
}
