import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDataSource _localStorageDataSource;

  LocalStorageRepositoryImpl(this._localStorageDataSource);

  @override
  Future<void> toggleFavoriteMovie(Movie movie) {
    return _localStorageDataSource.toggleFavoriteMovie(movie);
  }

  @override
  Future<bool> isFavoriteMovie(String movieId) {
    return _localStorageDataSource.isFavoriteMovie(movieId);
  }

  @override
  Future<List<Movie>> getFavoriteMovies({int limit = 10, int offset = 0}) {
    return _localStorageDataSource.getFavoriteMovies(
      limit: limit,
      offset: offset,
    );
  }
}
