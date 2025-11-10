import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource moviesDatasource;

  MovieRepositoryImpl(this.moviesDatasource);
  
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviesDatasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return moviesDatasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> topRated({int page = 1}) {
    return moviesDatasource.topRated(page: page);
  }
  
  @override
  Future<List<Movie>> upcoming({int page = 1}) {
    return moviesDatasource.upcoming(page: page);
  }
}
