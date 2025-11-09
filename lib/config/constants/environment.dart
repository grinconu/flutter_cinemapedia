import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static String baseUrlImage = 'https://image.tmdb.org/t/p';
  static String imageNotFound =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz1UanKyzGYddPrwmXXnmJByr_c1Euz_OjoA&s';
  static String apiKey = dotenv.env['THE_MOVIE_DB_KEY'] ?? 'Not Found Key';
}
