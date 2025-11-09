import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movie_db/movie_movie_db.dart';

class MovieMapper {
  static Movie movieDBtoEntity(MovieMovieDb movieDb) {
    return Movie(
      adult: movieDb.adult,
      backdropPath: movieDb.backdropPath != ''
          ? '${Environment.baseUrlImage}/w500/${movieDb.backdropPath}'
          : Environment.imageNotFound,
      genreIds: movieDb.genreIds.map((i) => i.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: movieDb.posterPath != ''
          ? '${Environment.baseUrlImage}/w500/${movieDb.posterPath}'
          : 'no-poster',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount,
    );
  }
}
