import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_list_view.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slides_show.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_app_bar.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  static const String routeName = 'home_view';
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.wait([
      ref.read(nowPlayingMoviesProvider.notifier).getMoreMovies(),
      ref.read(popularMoviesProvider.notifier).getMoreMovies(),
      ref.read(topRatedMoviesProvider.notifier).getMoreMovies(),
      ref.read(upcomingMoviesProvider.notifier).getMoreMovies(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(initialLoadingProvider);

    if (isLoading) {
      return const FullScreenLoader();
    }

    final nowPlayingSlideMovies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppBar()),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            RepaintBoundary(
              child: MoviesSlidesShow(movies: nowPlayingSlideMovies),
            ),
            RepaintBoundary(
              child: MovieHorizontalListView(
                movies: nowPlayingMovies,
                title: 'Now',
                subTitle: HumanFormats.getDay(DateTime.now()),
                loadNextPage:
                    ref.read(nowPlayingMoviesProvider.notifier).getMoreMovies,
              ),
            ),
            RepaintBoundary(
              child: MovieHorizontalListView(
                movies: upcomingMovies,
                title: 'Upcoming',
                loadNextPage:
                    ref.read(upcomingMoviesProvider.notifier).getMoreMovies,
              ),
            ),
            RepaintBoundary(
              child: MovieHorizontalListView(
                movies: popularMovies,
                title: 'Popular',
                loadNextPage:
                    ref.read(popularMoviesProvider.notifier).getMoreMovies,
              ),
            ),
            RepaintBoundary(
              child: MovieHorizontalListView(
                movies: topRatedMovies,
                title: 'The Best',
                loadNextPage:
                    ref.read(topRatedMoviesProvider.notifier).getMoreMovies,
              ),
            ),
            const SizedBox(height: 15),
          ]),
        ),
      ],
    );
  }
}