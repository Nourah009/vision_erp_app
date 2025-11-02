// services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';

class AuthService {
  static const String _userKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _rememberMeKey = 'remember_me';

  // تسجيل الدخول مع خاصية تذكرني
  static Future<Map<String, dynamic>> login(String username, String password, bool rememberMe) async {
    // محاكاة وقت الاتصال
    await Future.delayed(const Duration(seconds: 1));
    
    if (username.isEmpty) {
      return {
        'success': false,
        'user': null,
        'message': 'Please enter username'
      };
    }
    
    if (password.isEmpty) {
      return {
        'success': false,
        'user': null,
        'message': 'Please enter password'
      };
    }
    
    // أي بيانات غير فارغة مقبولة
    final user = UserModel.fromLogin(username);
    await _saveUserSession(user, rememberMe);
    
    return {
      'success': true,
      'user': user,
      'message': 'Login successful! Welcome ${user.username}'
    };
  }

  // حفظ جلسة المستخدم
  static Future<void> _saveUserSession(UserModel user, bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, user.username);
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setBool(_rememberMeKey, rememberMe);
  }

  // جلب بيانات المستخدم الحالي
  static Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_userKey);
    
    if (username != null) {
      return UserModel.fromLogin(username);
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
    
    // إذا لم يكن تذكرني مفعل، احذف كل البيانات
    final rememberMe = await getRememberMe();
    if (!rememberMe) {
      await prefs.remove(_userKey);
      await prefs.remove(_isLoggedInKey);
    }
    // احذف حالة تسجيل الدخول دائماً، لكن ابق بيانات المستخدم إذا كان تذكرني مفعل
    await prefs.setBool(_isLoggedInKey, false);
  }

  // تسجيل الخروج الكامل (حتى مع تذكرني)
  static Future<void> forceLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_rememberMeKey);
  }

  // التحقق من وجود مستخدم مسجل حالياً
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // التحقق من وجود بيانات مستخدم محفوظة
  static Future<bool> hasSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }

  // جلب حالة الجلسة الكاملة
  static Future<Map<String, dynamic>> getSessionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    final hasUser = prefs.containsKey(_userKey);
    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;
    final username = prefs.getString(_userKey);

    return {
      'isLoggedIn': isLoggedIn,
      'hasUser': hasUser,
      'rememberMe': rememberMe,
      'username': username,
    };
  }

  static Future<void> saveUserSession(UserModel user, bool rememberMe) async {}
}