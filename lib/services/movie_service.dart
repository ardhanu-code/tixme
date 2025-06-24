import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/movie_poster.dart';

class MovieService {
  static const String baseUrl = 'https://api.movieposterdb.com/v1/posters';

  static Future<List<MoviePoster>> getMoviePosters({
    String? search,
    int limit = 20,
  }) async {
    try {
      final Map<String, String> queryParameters = {'limit': limit.toString()};

      if (search != null && search.isNotEmpty) {
        queryParameters['search'] = search;
      }

      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParameters);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> posters = data['posters'] ?? [];

        return posters.map((json) => MoviePoster.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movie posters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching movie posters: $e');
    }
  }

  static Future<List<MoviePoster>> searchMovies(String query) async {
    return getMoviePosters(search: query);
  }
}
