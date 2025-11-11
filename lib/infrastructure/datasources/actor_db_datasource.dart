import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movie_db/credits_response.dart';
import 'package:dio/dio.dart';

class ActorDbDatasource extends ActorsDatasource {
  final dio = Dio(
      BaseOptions(
        baseUrl: Environment.baseUrl,
        queryParameters: {'api_key': Environment.apiKey, 'language': 'es-MX'},
      ),
    );

  @override
  Future<List<Actor>> getActors(String movieId) async {
    final response = await dio.get(
      '/movie/$movieId/credits'
    );
    if (response.statusCode != 200) throw Exception('Actors not found');
    final creditsResponse = CreditsResponse.fromJson(response.data);

    return creditsResponse.cast.map((cast) => ActorMapper.actorDBtoEntity(cast)).toList();
  }
}
