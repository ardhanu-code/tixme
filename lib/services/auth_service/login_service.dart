import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../endpoint/endpoint.dart';
import '../../preferences/preferences.dart';

class LoginService {
  // Login function that saves token to preferences
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      print('LoginService: Attempting login for $email');
      final response = await http.post(
        Uri.parse(Endpoint.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('LoginService: Response status: ${response.statusCode}');
      print('LoginService: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Save token to preferences if login is successful
        if (data['data'] != null && data['data']['token'] != null) {
          final token = data['data']['token'];
          print('LoginService: Token found in response: $token');
          await Preferences.saveLoginToken(token);
          print('LoginService: Token saved to preferences');

          // Verify token was saved
          final savedToken = await Preferences.getToken();
          print('LoginService: Verification - saved token: $savedToken');
        } else {
          print('LoginService: No token found in response structure');
          print('LoginService: Response data structure: $data');
        }

        return {'success': true, 'data': data};
      } else {
        print('LoginService: Login failed with status ${response.statusCode}');
        return {
          'success': false,
          'message': 'Login failed: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('LoginService: Error during login: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Get token from preferences
  static Future<String?> getTokenFromPreferences() async {
    return await Preferences.getToken();
  }

  // Check if user is logged in
  static Future<bool> isUserLoggedIn() async {
    return await Preferences.isLoggedIn();
  }

  // Logout function that removes token from preferences
  static Future<void> logout() async {
    await Preferences.removeToken();
  }
}
