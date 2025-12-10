// services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';

class AuthService {
  static const String baseUrl = 'https://fc.visioncit.com';
  static const String _userDataKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _rememberMeKey = 'remember_me';
  static const String _tokenKey = 'auth_token';

  // تسجيل الدخول مع API الحقيقي
  static Future<Map<String, dynamic>> login(String username, String password, bool rememberMe) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/UserInfo/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print('Login API Response: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        // تحقق من نجاح تسجيل الدخول بناءً على messageCode
        if (responseData['messageCode'] == 0) {
          // إنشاء نموذج المستخدم من بيانات API
          final user = UserModel(
            id: responseData['id']?.toString() ?? '0',
            username: responseData['username'] ?? '',
            name: responseData['name'] ?? responseData['username'] ?? '',
            nameNative: responseData['nameNative'] ?? '',
            nameForeign: responseData['nameForeign'] ?? '',
            employeeCode: responseData['employeeCode'] ?? '',
            organizationId: responseData['organizationId']?.toString() ?? '0',
            isCEO: responseData['isCEO'] ?? false,
            language: responseData['language'] ?? 'en',
            role: responseData['isCEO'] == true ? 'CEO' : 'Employee',
            department: 'Organization ${responseData['organizationId'] ?? 0}',
          );
          
          // حفظ جلسة المستخدم
          await _saveUserSession(user, rememberMe, responseData);
          
          return {
            'success': true,
            'user': user,
            'message': responseData['messageText'] ?? 'User ${responseData['username']} logged in successfully.',
          };
        } else {
          return {
            'success': false,
            'user': null,
            'message': responseData['messageText'] ?? 'Login failed. Please check your credentials.',
          };
        }
      } else if (response.statusCode == 401) {
        return {
          'success': false,
          'user': null,
          'message': 'Invalid username or password',
        };
      } else {
        return {
          'success': false,
          'user': null,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      print('Login error: $e');
      return {
        'success': false,
        'user': null,
        'message': 'Connection error. Please check your internet connection.',
      };
    }
  }

  // حفظ جلسة المستخدم مع بيانات API
  static Future<void> _saveUserSession(UserModel user, bool rememberMe, Map<String, dynamic> apiData) async {
    final prefs = await SharedPreferences.getInstance();
    
    // حفظ بيانات المستخدم كاملة
    await prefs.setString(_userDataKey, jsonEncode(user.toMap()));
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setBool(_rememberMeKey, rememberMe);
    
    // حفظ بيانات إضافية من API إذا لزم الأمر
    await prefs.setString('user_full_data', jsonEncode(apiData));
    
    print('User session saved for: ${user.username}');
  }

  // جلب بيانات المستخدم الحالي
  static Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);
    
    if (userDataString != null) {
      try {
        final userData = jsonDecode(userDataString);
        return UserModel.fromMap(userData);
      } catch (e) {
        print('Error parsing user data: $e');
        return null;
      }
    }
    
    return null;
  }

  // جلب حالة تذكرني
  static Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  // تسجيل الخروج
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = await getRememberMe();
    
    if (!rememberMe) {
      // إذا لم يكن تذكرني مفعل، احذف كل البيانات
      await prefs.remove(_userDataKey);
      await prefs.remove('user_full_data');
      await prefs.remove(_tokenKey);
    }
    
    // احذف حالة تسجيل الدخول دائماً
    await prefs.setBool(_isLoggedInKey, false);
    
    print('User logged out');
  }

  // تسجيل الخروج الكامل (حتى مع تذكرني)
  static Future<void> forceLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userDataKey);
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_rememberMeKey);
    await prefs.remove(_tokenKey);
    await prefs.remove('user_full_data');
    
    print('User force logged out');
  }

  // التحقق من وجود مستخدم مسجل حالياً
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // التحقق من وجود بيانات مستخدم محفوظة
  static Future<bool> hasSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userDataKey);
  }

  // جلب حالة الجلسة الكاملة
  static Future<Map<String, dynamic>> getSessionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    final hasUser = prefs.containsKey(_userDataKey);
    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;
    final userDataString = prefs.getString(_userDataKey);
    UserModel? user;
    
    if (userDataString != null) {
      try {
        user = UserModel.fromMap(jsonDecode(userDataString));
      } catch (e) {
        print('Error parsing user data in session status: $e');
      }
    }

    return {
      'isLoggedIn': isLoggedIn,
      'hasUser': hasUser,
      'rememberMe': rememberMe,
      'username': user?.username,
      'user': user,
    };
  }

  // الحصول على بيانات API الكاملة المحفوظة
  static Future<Map<String, dynamic>?> getFullApiData() async {
    final prefs = await SharedPreferences.getInstance();
    final apiDataString = prefs.getString('user_full_data');
    
    if (apiDataString != null) {
      try {
        return jsonDecode(apiDataString);
      } catch (e) {
        print('Error parsing API data: $e');
        return null;
      }
    }
    
    return null;
  }

  // دالة مساعدة لحفظ جلسة المستخدم (للتوافق مع الكود السابق)
  static Future<void> saveUserSession(UserModel user, bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, jsonEncode(user.toMap()));
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setBool(_rememberMeKey, rememberMe);
  }
}