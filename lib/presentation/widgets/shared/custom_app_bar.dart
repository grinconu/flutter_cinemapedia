import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('cinemapedia', style: titleStyle),

              const Spacer(),

              IconButton(
                onPressed: () {
                  final searchedMovies = ref.watch(searchedMoviesProvider);
                  final searchQuery = ref.watch(searchQueryProvider);
                  final router = GoRouter.of(context);

                  showSearch(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: searchedMovies,
                      searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery
                      ),
                  ).then((value) {
                    if (value == null) return;

                    router.push('/movie/${value.id}');
                  });
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
