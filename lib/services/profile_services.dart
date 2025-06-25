import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tixme/endpoint/endpoint.dart';
import 'package:tixme/preferences/preferences.dart';

class ProfileServices {
  static Future<Map<String, dynamic>> getProfile() async {
    final token = await Preferences.getToken();
    try {
      final response = await http.get(
        Uri.parse('${Endpoint.login}'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Get profile failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Get profile error: $e');
    }
  }
}
