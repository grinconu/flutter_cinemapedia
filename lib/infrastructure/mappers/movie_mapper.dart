import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movie_db/movie_db_detail.dart';
import 'package:cinemapedia/infrastructure/models/movie_db/movie_movie_db.dart';

class MovieMapper {
  static Movie movieDBtoEntity(MovieMovieDb movieDb) {
    return Movie(
      adult: movieDb.adult,
      backdropPath: movieDb.backdropPath != ''
          ? '${Environment.baseUrlImage}/w500/${movieDb.backdropPath}'
          : Environment.imageNotFound,
      genreIds: movieDb.genreIds.map((i) => i.toString()).toList(),
      id: movieDb.id.toString(),
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

  static Movie movieDBDetailToEntity(MovieDbDetail movieDbDetail) {
    return Movie(
      adult: movieDbDetail.adult,
      backdropPath: movieDbDetail.backdropPath != ''
          ? '${Environment.baseUrlImage}/w500/${movieDbDetail.backdropPath}'
          : Environment.imageNotFound,
      genreIds: movieDbDetail.genres.map((i) => i.name).toList(),
      id: movieDbDetail.id.toString(),
      originalLanguage: movieDbDetail.originalLanguage,
      originalTitle: movieDbDetail.originalTitle,
      overview: movieDbDetail.overview,
      popularity: movieDbDetail.popularity,
      posterPath: movieDbDetail.posterPath != ''
          ? '${Environment.baseUrlImage}/w500/${movieDbDetail.posterPath}'
          : Environment.imageNotFound,
      releaseDate: movieDbDetail.releaseDate,
      title: movieDbDetail.title,
      video: movieDbDetail.video,
      voteAverage: movieDbDetail.voteAverage,
      voteCount: movieDbDetail.voteCount,
    );
  }
}
