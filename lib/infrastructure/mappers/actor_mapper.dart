import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/movie_db/credits_response.dart';

class ActorMapper {
  static Actor actorDBtoEntity(Cast cast) {
    return Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? '${Environment.baseUrlImage}/w500/${cast.profilePath}'
          : 'https://i.pinimg.com/736x/2c/47/d5/2c47d5dd5b532f83bb55c4cd6f5bd1ef.jpg',
      character: cast.character,
    );
  }
}
