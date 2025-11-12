import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/movie/${movie.id}');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          movie.posterPath,
          fit: BoxFit.cover,
          width: 100,
          height: 150,
        ),
      ),
    );
  }
}
