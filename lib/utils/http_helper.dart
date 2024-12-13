
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '333a3dd3a3ddfde27635fd4e0cc4b487'; 

  // Fetch popular movies
  Future<List<dynamic>> fetchPopularMovies() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['results'];
      } else {
        throw Exception('Failed to fetch popular movies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching popular movies: $e');
    }
  }
}