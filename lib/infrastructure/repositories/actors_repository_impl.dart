import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorsDatasource;

  ActorsRepositoryImpl(this.actorsDatasource);
  @override
  Future<List<Actor>> getActors(String movieId) {
    return actorsDatasource.getActors(movieId);
  }

}
