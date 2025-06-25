import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tixme/endpoint/endpoint.dart';
import 'package:tixme/preferences/preferences.dart';

class MovieService {
  static Future<Map<String, dynamic>> addMovie({
    required String title,
    required String description,
    required String genre,
    required String director,
    required String writer,
    required String stats,
    required String imageBase64,
  }) async {
    try {
      // Ambil token dulu dari Preferences
      final token = await Preferences.getToken();
      if (token == null) {
        throw Exception('Token not found. Please login first.');
      }

      final response = await http.post(
        Uri.parse('${Endpoint.film}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'title': title,
          'description': description,
          'genre': genre,
          'director': director,
          'writer': writer,
          'stats': stats,
          'image_base64': imageBase64,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 422) {
        final errorData = jsonDecode(response.body);
        final errors = errorData['errors'] ?? {};
        final errorMessages = <String>[];

        errors.forEach((key, value) {
          if (value is List) {
            errorMessages.addAll(value.cast<String>());
          }
        });
        throw Exception('Validation failed: ${errorMessages.join(', ')}');
      } else {
        throw Exception('Add movie failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Add movie error: $e');
    }
  }

  static Future<Map<String, dynamic>> getMovies() async {
    final token = await Preferences.getToken();
    try {
      final response = await http.get(
        Uri.parse('${Endpoint.film}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Get movies failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Get movies error: $e');
    }
  }
}
