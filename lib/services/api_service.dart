import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://test.visioncit.com';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      final loginData = {
        'username': username.trim(),
        'password': password.trim(),
      };

      print('🔐 Attempting login with:');
      print('📧 Username: $username');
      print('🔑 Password: ${'*' * password.length}');
      print('🌐 URL: $baseUrl/api/UserAccount/Login');
      print('📦 Request data: $loginData');

      final response = await http.post(
        Uri.parse('$baseUrl/api/UserAccount/Login'),
        headers: headers,
        body: json.encode(loginData),
      ).timeout(const Duration(seconds: 30));

      print('📡 Response received:');
      print('📊 Status Code: ${response.statusCode}');
      print('📄 Response Body: ${response.body}');
      print('🔗 Response Headers: ${response.headers}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('✅ Login successful!');
        return {
          'success': true,
          'data': responseData,
        };
      } else {
        print('❌ Login failed with status: ${response.statusCode}');
        return {
          'success': false,
          'error': 'HTTP ${response.statusCode}',
          'message': _getErrorMessage(response.statusCode, response.body),
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      print('💥 Exception during login: $e');
      print('🔄 Exception type: ${e.runtimeType}');
      
      return {
        'success': false,
        'error': e.toString(),
        'message': _getExceptionMessage(e),
      };
    }
  }

  // Test method to check if we can reach the server
  static Future<Map<String, dynamic>> testConnection() async {
    try {
      print('🔍 Testing connection to: $baseUrl');
      
      final response = await http.get(
        Uri.parse(baseUrl),
      ).timeout(const Duration(seconds: 10));

      print('📡 Connection test response: ${response.statusCode}');
      
      return {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'message': 'Server is reachable',
      };
    } catch (e) {
      print('💥 Connection test failed: $e');
      return {
        'success': false,
        'error': e.toString(),
        'message': 'Cannot reach server',
      };
    }
  }

  static String _getErrorMessage(int statusCode, String body) {
    try {
      final errorData = json.decode(body);
      return errorData['message'] ?? errorData['error'] ?? 'Unknown error occurred';
    } catch (e) {
      switch (statusCode) {
        case 400:
          return 'Bad request - Invalid input data';
        case 401:
          return 'Invalid username or password';
        case 403:
          return 'Access denied - Check your permissions';
        case 404:
          return 'Login endpoint not found';
        case 500:
          return 'Server error - Please try again later';
        default:
          return 'Login failed with status code: $statusCode';
      }
    }
  }

  static String _getExceptionMessage(dynamic e) {
    if (e is http.ClientException) {
      return 'Network error - Cannot connect to server';
    } else if (e is FormatException) {
      return 'Invalid response format from server';
    } else if (e is TypeError) {
      return 'Type error in response handling';
    } else {
      return 'Connection error: ${e.toString()}';
    }
  }
}