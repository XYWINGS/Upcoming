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
      height: height * 0.9,
      width: width * 0.35,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: DecorationImage(
          image: NetworkImage(posterUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }

  Widget movieInfoWidget() {
    return SizedBox(
      height: height,
      width: width * 0.65,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title and rating
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    movie.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    movie.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6.0),

            /// Language, Age, Release Date
            Text(
              '${movie.language.toUpperCase()} | R: ${movie.isAdult ? "18+" : "PG"} | ${movie.releaseDate}',
              style: const TextStyle(color: Colors.white70, fontSize: 12.0),
            ),

            const SizedBox(height: 8.0),

            /// Description
            Text(
              movie.description,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.0,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
