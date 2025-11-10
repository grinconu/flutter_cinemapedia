import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeVIew(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeVIew extends ConsumerStatefulWidget {
  @override
  ConsumerState<_HomeVIew> createState() => _HomeVIewState();
}

class _HomeVIewState extends ConsumerState<_HomeVIew> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).getNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingSlideMovies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [

                MoviesSlidesShow(movies: nowPlayingSlideMovies),

                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'Now',
                  subTitle: HumanFormats.getDay(DateTime.now()),
                  loadNextPage: ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .getNowPlayingMovies,
                ),

                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'Next',
                  loadNextPage: ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .getNowPlayingMovies,
                ),

                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'Popular',
                  loadNextPage: ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .getNowPlayingMovies,
                ),

                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'The Best',
                  loadNextPage: ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .getNowPlayingMovies,
                ),

                const SizedBox(height: 15),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}
