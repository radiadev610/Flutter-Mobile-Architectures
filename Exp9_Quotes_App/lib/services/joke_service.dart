import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke_model.dart';

class JokeService {
  static const String _jokeUrl =
      'https://official-joke-api.appspot.com/random_joke';

  static Future<Joke> fetchRandomJoke() async {
    final response = await http
        .get(Uri.parse(_jokeUrl))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      return Joke.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load joke from REST API.');
    }
  }
}