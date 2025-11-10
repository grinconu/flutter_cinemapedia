import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPLayingMovies = ref.watch(nowPlayingMoviesProvider);
  if (nowPLayingMovies.isEmpty) return [];

  return nowPLayingMovies.sublist(0, 5);
});
