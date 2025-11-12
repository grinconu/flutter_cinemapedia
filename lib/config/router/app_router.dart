import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/screens/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeView(),
          routes: [
            GoRoute(
              path: 'movie/:id',
              name: MovieScreen.routeName,
              builder: (context, state) =>
                  MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id'),
            ),
          ],
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesView(),
        ),
      ],
    ),

    //Routes Old
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.routeName,
    //   builder: (context, state) => const HomeScreen(childView: HomeView(),),
    //   routes: [
    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MovieScreen.routeName,
    //       builder: (context, state) =>
    //           MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id'),
    //     ),
    //   ],
    // ),
  ],
);
