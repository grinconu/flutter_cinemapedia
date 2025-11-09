import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
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
    final response = await dio.get('/movie/now_playing?page=$page');
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    return movieDbResponse.results
        .where((movie) => movie.posterPath != 'no-poster')
        .map((movie) => MovieMapper.movieDBtoEntity(movie))
        .toList();
  }
}
