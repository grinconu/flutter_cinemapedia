import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  void _showLanguageMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final currentLocale = context.locale;

    showMenu<Locale>(
      context: context,
      position: position,
      items: [
        PopupMenuItem<Locale>(
          value: const Locale('en'),
          child: Row(
            children: [
              const Text('🇺🇸'),
              const SizedBox(width: 10),
              Text('language.english'.tr()),
              if (currentLocale == const Locale('en'))
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.check, size: 18),
                ),
            ],
          ),
        ),
        PopupMenuItem<Locale>(
          value: const Locale('es'),
          child: Row(
            children: [
              const Text('🇪🇸'),
              const SizedBox(width: 10),
              Text('language.spanish'.tr()),
              if (currentLocale == const Locale('es'))
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.check, size: 18),
                ),
            ],
          ),
        ),
      ],
    ).then((selectedLocale) {
      if (selectedLocale != null && context.mounted) {
        context.setLocale(selectedLocale);
      }
    });
  }

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
              GestureDetector(
                onTap: () => _showLanguageMenu(context),
                child: Row(
                  children: [
                    Text('app.name'.tr(), style: titleStyle),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, color: colors.primary, size: 20),
                  ],
                ),
              ),

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
