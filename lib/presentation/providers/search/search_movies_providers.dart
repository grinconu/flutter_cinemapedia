import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
      return SearchedMoviesNotifier(
        searchMovies: ref.read(movieRepositoryProvider).searchMovies,
        ref: ref,
      );
    });

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
    : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    ref.read(searchQueryProvider.notifier).state = query;
    final movies = await searchMovies(query);
    state = movies;
    return movies;
  }
}
