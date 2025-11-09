import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = 'home-screen';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).getNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    if (nowPlayingMovies.isEmpty)
      return const Center(child: CircularProgressIndicator());

    return Scaffold(
      body: ListView.builder(
        itemCount: nowPlayingMovies.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(nowPlayingMovies[index].title),
          subtitle: Image(
            image: NetworkImage(nowPlayingMovies[index].posterPath),
          ),
        ),
      ),
    );
  }
}
