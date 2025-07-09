import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../core/errors/exceptions.dart';
import '../secure_storage.dart';

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({required this.baseUrl, required this.client}){
    print('ApiService initialized with baseUrl: $baseUrl');
  }

  Future<dynamic> get(String endpoint) async {
    final token = await SecureStorage.getToken();
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    try {
      final fullUri = Uri.parse('$baseUrl$endpoint');
      print('ApiService attempting to GET: $fullUri');
      final response = await client.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      print('Error in GET request: $e');
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
      print('ApiService POST response status for $endpoint: ${response.statusCode}'); // LOGGING
      print('ApiService POST response body for $endpoint: ${response.body}'); // LOGGING


      return _handleResponse(response);
    } catch (e) {
      print('Error in POST request: $e');
      throw ServerException(e.toString());
    }
  }

  // --- TAMBAHKAN METODE DELETE INI ---
  Future<dynamic> delete(String endpoint, {bool requiresAuth = true}) async {
    try {
      final token = requiresAuth ? await SecureStorage.getToken() : null;
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final fullUri = Uri.parse('$baseUrl$endpoint');
      print('ApiService attempting to DELETE: $fullUri');
      final response = await client.delete(
        fullUri,
        headers: headers,
      );
      print('ApiService DELETE response status for $endpoint: ${response.statusCode}'); // LOGGING
      print('ApiService DELETE response body for $endpoint: ${response.body}'); // LOGGING

      return _handleResponse(response); // Gunakan handler respons yang sama
    } catch (e) {
      print('Error in DELETE request: $e');
      throw ServerException(e.toString());
    }
  }

  Future<dynamic> postFormData(
      String endpoint, {
        required Map<String, String> fields,
        File? file,
        String fileFieldName = 'image', // Default field name for the image
        bool requiresAuth = true,
      }) async {
    try {
      final token = requiresAuth ? await SecureStorage.getToken() : null;
      final fullUri = Uri.parse('$baseUrl$endpoint');
      final request = http.MultipartRequest('POST', fullUri);

      // Add fields
      request.fields.addAll(fields);

      // Add file if it exists
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath(
          fileFieldName,
          file.path,
          filename: file.path.split('/').last,
        ));
      }

      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      print('ApiService attempting to POST form-data to: $fullUri');
      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      print('ApiService POST form-data response status for $endpoint: ${response.statusCode}');
      print('ApiService POST form-data response body for $endpoint: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      print('Error in POST form-data request: $e');
      throw ServerException(e.toString());
    }
  }

  dynamic _handleResponse(http.Response response) {
    try {
      final responseJson = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseJson;
      } else if (response.statusCode == 401) {
        // Mungkin Anda ingin melakukan sesuatu yang spesifik di sini,
        // seperti navigasi ke halaman login atau membersihkan token.
        throw ServerException('Unauthorized: Please login again.');
      } else if (response.statusCode == 404) {
        throw ServerException('Resource not found (404).');
      } else if (response.statusCode >= 500) {
        throw ServerException('Server Error (${response.statusCode}): Please try again later.');
      } else {
        // Mencoba mendapatkan pesan error dari respons server jika ada
        final message = responseJson?['message'] ?? responseJson?['error'] ?? 'An unknown error occurred.';
        throw ServerException('Error (${response.statusCode}): $message');
      }
    } on FormatException catch (e) {
      // Jika response.body bukan JSON yang valid
      print('Error decoding JSON response: $e');
      throw ServerException('Failed to parse server response. Body: ${response.body}');
    }
  }
}