import 'package:cinemapedia/config/database/database.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:drift/drift.dart' as drift;

class DriftDataSource extends LocalStorageDataSource {
  final AppDatabase database;

  DriftDataSource([AppDatabase? database]) : database = database ?? db;

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    final movieId = int.parse(movie.id);
    final isFavorite = await isFavoriteMovie(movie.id);

    if (isFavorite) {
      final deleteQuery = database.delete(database.favoritesMovies)
        ..where((table) => table.movieId.equals(movieId));

      await deleteQuery.go();
      return;
    }

    await database
        .into(database.favoritesMovies)
        .insert(
          FavoritesMoviesCompanion.insert(
            movieId: movieId,
            backdropPath: movie.backdropPath,
            originalTitle: movie.originalTitle,
            posterPath: movie.posterPath,
            title: movie.title,
            voteAverage: drift.Value(movie.voteAverage),
          ),
        );
  }

  @override
  Future<bool> isFavoriteMovie(String movieId) async {
    final query = database.select(database.favoritesMovies)
      ..where((table) => table.movieId.equals(int.parse(movieId)));

    final result = await query.getSingleOrNull();

    return result != null;
  }

  @override
  Future<List<Movie>> getFavoriteMovies({
    int limit = 10,
    int offset = 0,
  }) async {
    final query = database.select(database.favoritesMovies)
      ..limit(limit, offset: offset);
    final result = await query.get();
    return result.map((e) => e.toMovie()).toList();
  }
}
