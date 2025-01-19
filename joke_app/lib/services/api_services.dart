import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:joke_app/models/joke.dart';

class ApiServices {
  static const String baseUrl = 'https://official-joke-api.appspot.com';

  static Future<List<String>> fetchJokeTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/types'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => e.toString()).toList();
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  static Future<List<Joke>> fetchJokesByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/jokes/$type/ten'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Joke.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load jokes for type $type');
    }
  }

  static Future<Joke> fetchRandomJoke() async {
    final response = await http.get(Uri.parse('$baseUrl/random_joke'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return Joke.fromJson(jsonData);
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}
