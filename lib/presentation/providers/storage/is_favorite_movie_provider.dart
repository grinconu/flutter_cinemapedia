import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFavoriteMovieProvider = FutureProvider.family<bool, String>((
  ref,
  movieId,
) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isFavoriteMovie(movieId);
});
