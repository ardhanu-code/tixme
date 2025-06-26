import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tixme/endpoint/endpoint.dart';
import 'package:tixme/models/tambah_jadwal_response.dart';
import 'package:tixme/preferences/preferences.dart';

class TambahJadwalFilmService {
  static Future<TambahFilmResponse> addSchedule({
    required int filmId,
    required DateTime startTime,
  }) async {
    try {
      // Ambil token dulu dari Preferences
      final token = await Preferences.getToken();
      if (token == null) {
        throw Exception('Token not found. Please login first.');
      }

      // Format datetime to Y-m-d H:i:s format
      final formattedDateTime = DateFormat(
        'yyyy-MM-dd HH:mm:ss',
      ).format(startTime);

      final response = await http.post(
        Uri.parse('${Endpoint.schedules}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'film_id': filmId, 'start_time': formattedDateTime}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return tambahFilmResponseFromJson(response.body);
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
        throw Exception('Add schedule failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Add schedule error: $e');
    }
  }
}
