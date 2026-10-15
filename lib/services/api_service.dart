import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class ApiService {
  static const String _usersUrl = 'https://jsonplaceholder.typicode.com/users';
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<User>> fetchUsers() async {
    try {
      final response = await _client
          .get(
            Uri.parse(_usersUrl),
            headers: const {'Accept': 'application/json'},
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final dynamic decoded = jsonDecode(response.body);
        if (decoded is List) {
          return decoded
              .whereType<Map<String, dynamic>>()
              .map(User.fromJson)
              .toList();
        }
        throw const ApiException('Unexpected data format received from server.');
      } else {
        throw ApiException(
          'Server returned status code ${response.statusCode}. Please try again later.',
        );
      }
    } on TimeoutException {
      throw const ApiException(
        'Request timed out. Please check your internet connection and try again.',
      );
    } on FormatException {
      throw const ApiException(
        'Failed to parse server response. Please try again later.',
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw const ApiException(
        'Unable to connect to the server. Please check your network connection.',
      );
    }
  }
}
