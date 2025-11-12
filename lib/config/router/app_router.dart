import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/screens/views/movies/categories_view.dart';
import 'package:cinemapedia/presentation/screens/views/views.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell,
          ) {
            return HomeScreen(childView: navigationShell);
          },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: HomeView.routeName,
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              name: CategoriesView.routeName,
              builder: (context, state) => const CategoriesView(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              name: FavoritesView.routeName,
              builder: (context, state) => const FavoritesView(),
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: '/movie/:id',
      name: MovieScreen.routeName,
      builder: (context, state) =>
          MovieScreen(movieId: state.pathParameters['id'] ?? 'no-id'),
    ),
  ],
);
