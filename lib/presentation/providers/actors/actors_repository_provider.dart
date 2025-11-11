import 'package:cinemapedia/infrastructure/datasources/actor_db_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actors_repository_.impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider(
  (ref) => ActorsRepositoryImpl(ActorDbDatasource()),
);