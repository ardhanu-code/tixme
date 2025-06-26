import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tixme/endpoint/endpoint.dart';
import 'package:tixme/preferences/preferences.dart';

class JadwalService {
  static Future<Map<String, dynamic>> getSchedules() async {
    try {
      // Ambil token dulu dari Preferences
      final token = await Preferences.getToken();
      if (token == null) {
        throw Exception('Token not found. Please login first.');
      }

      final response = await http.get(
        Uri.parse('${Endpoint.schedules}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception('401');
      } else {
        throw Exception('Failed to fetch schedules: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Get schedules error: $e');
    }
  }
}
