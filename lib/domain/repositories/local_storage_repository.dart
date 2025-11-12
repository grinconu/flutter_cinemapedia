import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavoriteMovie(Movie movie);
  Future<bool> isFavoriteMovie(String movieId);
  Future<List<Movie>> getFavoriteMovies({
    int limit = 10,
    int offset = 0,
  });
}