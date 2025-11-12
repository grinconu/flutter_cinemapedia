import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef MovieSelectedCallback = void Function(BuildContext context, Movie movie);

class MovieSearchView extends StatelessWidget {
  final Movie movie;
  final MovieSelectedCallback onMovieSelected;
  const MovieSearchView({super.key, required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            //Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return FadeIn(child: child);
                  },
                ),
              ),
            ),

            const SizedBox(width: 10),

            //Description
            SizedBox(
              width: size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),

                  (movie.overview.length > 100)
                      ? Text(
                          movie.overview.substring(0, 100),
                          style: textStyle.bodyMedium,
                        )
                      : Text(movie.overview, style: textStyle.bodyMedium),

                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.popularity, 1),
                        style: textStyle.bodyMedium?.copyWith(
                          color: Colors.yellow.shade800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyle.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
