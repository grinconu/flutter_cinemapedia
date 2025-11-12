import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class FavoritesMovies extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get movieId => integer().named('movie_id')();
  TextColumn get backdropPath => text().named('backdrop_path')();
  TextColumn get originalTitle => text().named('original_title')();
  TextColumn get posterPath => text().named('poster_path')();
  TextColumn get title => text()();
  RealColumn get voteAverage =>
      real().named('vote_average').withDefault(const Constant(0.0))();
}

@DriftDatabase(tables: [FavoritesMovies])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

final db = AppDatabase();
