//Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
//Models
import 'package:movie_app/models/movie.dart';

class MovieTile extends StatelessWidget {
  final GetIt getIt = GetIt.instance;
  final double height;
  final double width;
  final Movie movie;

  MovieTile({
    super.key,
    required this.height,
    required this.width,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [moviePosterWidget(movie.posterUrl()), movieInfoWidget()],
    );
  }

  Widget moviePosterWidget(String posterUrl) {
    return Container(
      height: height,
      width: width * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget movieInfoWidget() {
    return Container(
      height: height,
      width: width * 0.65,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: width * 0.55,
                child: Text(
                  movie.name,
                  style: TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(
            child: Text(
              '${movie.language.toUpperCase()} | R: ${movie.isAdult} | ${movie.releaseDate}',
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ),
          SizedBox(
            child: Text(
              movie.description,
              style: TextStyle(color: Colors.white, fontSize: 12.0),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
