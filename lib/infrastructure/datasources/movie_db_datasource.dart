import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movie_db/movie_db_detail.dart';
import 'package:cinemapedia/infrastructure/models/movie_db/movie_db_response.dart';
import 'package:dio/dio.dart';

class MovieDbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.baseUrl,
      queryParameters: {'api_key': Environment.apiKey, 'language': 'es-MX'},
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    return _getResponseMovies(response.data);
  }

  List<Movie> _getResponseMovies(Map<String, dynamic> data) {
    final movieDbResponse = MovieDbResponse.fromJson(data);
    return movieDbResponse.results
        .where((movie) => movie.posterPath != 'no-poster')
        .map((movie) => MovieMapper.movieDBtoEntity(movie))
        .toList();
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    return _getResponseMovies(response.data);
  }

  @override
  Future<List<Movie>> topRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    return _getResponseMovies(response.data);
  }

  @override
  Future<List<Movie>> upcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    return _getResponseMovies(response.data);
  }

  @override
  Future<Movie> getMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId');
    if (response.statusCode != 200) throw Exception('Movie not found');

    return MovieMapper.movieDBDetailToEntity(
      MovieDbDetail.fromJson(response.data),
    );
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': query, 'page': page},
    );

    return _getResponseMovies(response.data);
  }
}
