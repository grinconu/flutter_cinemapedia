import 'package:cinemapedia/infrastructure/datasources/movie_db_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider(
  (ref) => MovieRepositoryImpl(MovieDbDatasource()),
);
