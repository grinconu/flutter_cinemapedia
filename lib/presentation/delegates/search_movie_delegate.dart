import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_search_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> debouncedLoading = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    this.initialMovies = const [],
  });

  void clearStreams() {
    debouncedMovies.close();
    _debounceTimer?.cancel();
  }

  void _onQueryChange(String query) {
    debouncedLoading.add(true);

    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
      initialMovies = movies;
      debouncedLoading.add(false);
    });
  }

  @override
  String get searchFieldLabel => 'search.search_movie'.tr();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: debouncedLoading.stream,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 1),
              spins: 1,
              infinite: true,
              child: IconButton(onPressed: () {}, icon: Icon(Icons.refresh_outlined)),
            );
          }

          return IconButton(
            onPressed: () {
              query = '';
            },
            icon: Icon(Icons.clear),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultSuggestion();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);

    return _buildResultSuggestion();
  }

  Widget _buildResultSuggestion() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        if (movies.isEmpty) {
          return Center(child: Text('search.no_results'.tr()));
        }

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: MovieSearchView(
                movie: movies[index],
                onMovieSelected: (context, movie) {
                  close(context, movie);
                  clearStreams();
                },
              ),
            );
          },
        );
      },
    );
  }
}
