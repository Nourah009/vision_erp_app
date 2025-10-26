import 'api_service.dart';

class AuthService {
  static Future<Map<String, dynamic>> loginUser({
    required String username,
    required String password,
  }) async {
    print('🚀 Starting login process...');
    
    // First test the connection
    final connectionTest = await ApiService.testConnection();
    if (!connectionTest['success']) {
      print('Connection test failed');
      return {
        'success': false,
        'error': connectionTest['error'],
        'message': 'Cannot connect to server. Please check:\n• Internet connection\n• Server availability\n• URL correctness',
      };
    }

    print('✅ Server is reachable, proceeding with login...');
    
    final result = await ApiService.login(
      username: username,
      password: password,
    );

    if (result['success'] == true) {
      final responseData = result['data'] as Map<String, dynamic>;
      
      // Extract user data - adjust these keys based on your API response
      final String? token = responseData['token'] ?? responseData['access_token'];
      final String? userId = responseData['user_id']?.toString() ?? responseData['id']?.toString();
      final String? userName = responseData['user_name'] ?? responseData['username'] ?? responseData['name'];
      final String? userRole = responseData['user_role'] ?? responseData['role'];
      final String? companyId = responseData['company_id']?.toString();

      // Store user data
      await _storeUserData(
        token: token,
        userId: userId,
        userName: userName,
        userRole: userRole,
        companyId: companyId,
      );

      return {
        'success': true,
        'user': {
          'token': token,
          'userId': userId,
          'userName': userName,
          'userRole': userRole,
          'companyId': companyId,
        },
      };
    } else {
      return {
        'success': false,
        'error': result['error'],
        'message': result['message'],
        'statusCode': result['statusCode'],
      };
    }
  }

  static Future<void> _storeUserData({
    String? token,
    String? userId,
    String? userName,
    String? userRole,
    String? companyId,
  }) async {
    print('Storing user data:');
    print('User ID: $userId');
    print('User Name: $userName');
    print('User Role: $userRole');
    print('Company ID: $companyId');
    print('Token: ${token != null ? 'Received' : 'Not provided'}');
    
  }

  static Future<void> logout() async {
    print('🚪Logging out user');
  }

  static Future<bool> isLoggedIn() async {
    return false;
  }
}