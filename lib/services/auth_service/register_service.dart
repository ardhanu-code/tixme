import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tixme/endpoint/endpoint.dart';
import 'package:tixme/models/register_response.dart';

class RegisterService {
  static Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Endpoint.register),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      if (response.statusCode == 200) {
        return registerResponseFromJson(response.body);
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
        throw Exception('Registration failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  static Future<RegisterResponse> updateUser({
    required String token,
    required int userId,
    String? name,
    String? email,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${Endpoint.baseUrl}/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          if (name != null) 'name': name,
          if (email != null) 'email': email,
        }),
      );

      if (response.statusCode == 200) {
        return registerResponseFromJson(response.body);
      } else {
        throw Exception('Update failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Update error: $e');
    }
  }

  static Future<void> deleteUser({
    required String token,
    required int userId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('${Endpoint.baseUrl}/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Delete failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Delete error: $e');
    }
  }

  static Future<RegisterResponse> getUser({
    required String token,
    required int userId,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${Endpoint.baseUrl}/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return registerResponseFromJson(response.body);
      } else {
        throw Exception('Get user failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Get user error: $e');
    }
  }
}
