import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorMapNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorMapNotifier(getActors: actorsRepository.getActors);
});

typedef GetActorByMovieCallback = Future<List<Actor>> Function(String movieId);

class ActorMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorByMovieCallback getActors;

  ActorMapNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state.containsKey(movieId)) return;

    final actors = await getActors(movieId);

    state = {...state, movieId : actors};
  }
}