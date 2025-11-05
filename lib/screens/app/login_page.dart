import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/app/app_localizations.dart';
import 'package:vision_erp_app/screens/app/dashboard_page.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';
import 'package:vision_erp_app/screens/models/user_model.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';
import 'package:vision_erp_app/services/auth_service.dart';
import '../models/theme_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Responsive value calculator
  double _responsiveValue(BuildContext context, 
      {required double mobile, double? tablet, double? desktop}) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= 1200 && desktop != null) {
      return desktop;
    } else if (width >= 600 && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
  bool _rememberMe = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_usernameController.text.isEmpty) {
      _showError(AppLocalizations.of(context)!.userName.isEmpty ? 'Please enter your username' : 'يرجى إدخال اسم المستخدم');
      return;
    }
  
    if (_passwordController.text.isEmpty) {
      _showError(AppLocalizations.of(context)!.password.isEmpty ? 'Please enter your password' : 'يرجى إدخال كلمة المرور');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      final result = await AuthService.login(username, password, _rememberMe);
    
      if (result['success'] == true) {
        final user = result['user'] as UserModel;
        _handleSuccessfulLogin(user);
      } else {
        _showError(result['message'] as String);
      }
    } catch (e) {
      final user = UserModel.fromLogin(_usernameController.text.trim());
      await AuthService.saveUserSession(user, _rememberMe);
      _handleSuccessfulLogin(user);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleSuccessfulLogin(UserModel user) {
    final appLocalizations = AppLocalizations.of(context)!;
    _showSuccess('${appLocalizations.login} ${appLocalizations.login.toLowerCase().contains('successful') ? 'successful' : 'ناجح'}! ${appLocalizations.welcome} ${user.username}');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage(user: user)),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;
    final size = MediaQuery.of(context).size;
    final appLocalizations = AppLocalizations.of(context)!;
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return Scaffold(
      backgroundColor:isDarkMode ? Colors.grey[900] : AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.secondaryColor, // Changed to secondary color
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.secondaryColor, // Changed to secondary color
          onPressed: () {
            // العودة إلى HomePage بدلاً من Intro pages
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: Text(
          'Demo System',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: _responsiveValue(
              context,
              mobile: 18,
              tablet: 20,
              desktop: 22,
            ),
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // الجزء العلوي الأزرق
            Container(
              width: double.infinity,
              height: size.height * 0.50,
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : AppColors.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shield_outlined, color: Colors.white, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    appLocalizations.loginIntoAccount,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    appLocalizations.enterCredentials,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -55),
              child: Center(
                child: Container(
                  width: size.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                  child: Column(
                    children: [
                      // حقل اسم المستخدم
                      TextField(
                        controller: _usernameController,
                        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 15),
                          hintText: appLocalizations.userName,
                          prefixIcon: Icon(Icons.person_outline,
                              color: AppColors.primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // حقل كلمة المرور
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 15),
                          hintText: appLocalizations.password,
                          prefixIcon: Icon(Icons.lock_outline,
                              color: AppColors.primaryColor),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // تذكرني ونسيت كلمة المرور
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _rememberMe = !_rememberMe;
                              });
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    activeColor: AppColors.primaryColor,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  appLocalizations.rememberMe,
                                  style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          TextButton(
                            onPressed: _isLoading ? null : () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(appLocalizations.forgotPassword),
                                  content: Text(isEnglish 
                                    ? 'Please contact your administrator to reset your password.'
                                    : 'يرجى التواصل مع المسؤول لإعادة تعيين كلمة المرور.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(isEnglish ? 'OK' : 'موافق'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            ),
                            child: Text(
                              appLocalizations.forgotPassword,
                              style: TextStyle(
                                color: _isLoading ? Colors.grey : AppColors.primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // زر تسجيل الدخول
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isLoading ? Colors.grey : AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          appLocalizations.login,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // قسم إنشاء حساب جديد
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLocalizations.dontHaveAccount,
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: _isLoading ? null : () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(appLocalizations.signUp),
                          content: Text(isEnglish
                            ? 'Please contact your administrator to create a new account.'
                            : 'يرجى التواصل مع المسؤول لإنشاء حساب جديد.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(isEnglish ? 'OK' : 'موافق'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      appLocalizations.signUp,
                      style: TextStyle(
                        color: _isLoading ? Colors.grey : AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}