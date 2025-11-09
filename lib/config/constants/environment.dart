import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static String apiKey = dotenv.env['THE_MOVIE_DB_KEY'] ?? 'Not Found Key';
}
