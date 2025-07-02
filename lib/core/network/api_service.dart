import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/errors/exceptions.dart';
import '../secure_storage.dart';

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({required this.baseUrl, required this.client});

  Future<dynamic> get(String endpoint) async {
    final token = await SecureStorage.getToken();
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      final response = await client.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<dynamic> post(String endpoint, {required Map<String, dynamic> body, bool requiresAuth = true}) async {
    try {
      final token = requiresAuth ? await SecureStorage.getToken() : null;

      final response = await client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null && !endpoint.contains('/register'))
            'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  dynamic _handleResponse(http.Response response) {
    final responseJson = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return responseJson;
    } else if (response.statusCode == 401) {
      throw ServerException('Unauthorized');
    } else if (response.statusCode == 404) {
      throw ServerException('Not Found');
    } else if (response.statusCode >= 500) {
      throw ServerException('Server Error');
    } else {
      throw ServerException(responseJson['message'] ?? 'Something went wrong');
    }
  }
}