import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/intro_page_1.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';
import 'package:vision_erp_app/screens/app/dashboard_page.dart';
import 'package:vision_erp_app/services/auth_service.dart';
import 'package:vision_erp_app/services/shared_preferences_service.dart';
import '../models/theme_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3)); // وقت السبلاش سكرين

    if (mounted) {
      // أولاً: التحقق من إذا كان هناك مستخدم مسجل الدخول
      final isUserLoggedIn = await AuthService.isUserLoggedIn();
      final hasSavedUser = await AuthService.hasSavedUser();
      
      print('User logged in status: $isUserLoggedIn');
      print('Has saved user: $hasSavedUser');

      if (isUserLoggedIn && hasSavedUser) {
        // إذا كان المستخدم مسجل الدخول، انتقل مباشرة للداشبورد
        final user = await AuthService.getCurrentUser();
        print('User is logged in - navigating directly to DashboardPage');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage(user: user!)),
        );
      } else {
        // إذا لم يكن مسجل الدخول، تابع التدفق العادي
        _checkIntroStatus();
      }
    }
  }

  _checkIntroStatus() async {
    // Check if intro has been shown before
    bool introShown = await SharedPreferencesService.isIntroShown();
    
    print('Intro shown status: $introShown');
    
    if (introShown) {
      // Intro already shown - go directly to home page
      print('Intro already shown - navigating directly to HomePage');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Intro not shown yet - show intro pages
      print('Intro not shown yet - navigating to IntroPage1');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroPage1()),
      );
    }
  }

  // باقي الكود يبقى كما هو...
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: _responsiveValue(
              context,
              mobile: 20,
              tablet: 40,
              desktop: 60,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo - Responsive sizing
              Container(
                width: _responsiveValue(
                  context,
                  mobile: 170,
                  tablet: 200,
                  desktop: 250,
                ),
                height: _responsiveValue(
                  context,
                  mobile: 170,
                  tablet: 200,
                  desktop: 250,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    'lib/assets/images/vision_erp_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              
              SizedBox(height: _responsiveValue(
                context,
                mobile: 30,
                tablet: 40,
                desktop: 50,
              )),
              
              // Tagline
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _responsiveValue(
                    context,
                    mobile: 20,
                    tablet: 40,
                    desktop: 60,
                  ),
                ),
                child: Text(
                  'Powering Digital Transformation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    fontSize: _responsiveValue(
                      context,
                      mobile: 14,
                      tablet: 16,
                      desktop: 18,
                    ),
                    color: AppColors.primaryColor,
                    letterSpacing: _responsiveValue(
                      context,
                      mobile: 0.8,
                      tablet: 1.0,
                      desktop: 1.2,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: _responsiveValue(
                context,
                mobile: 50,
                tablet: 60,
                desktop: 70,
              )),
              
              // Loading indicator with login status
              FutureBuilder<Map<String, dynamic>>(
                future: AuthService.getSessionStatus(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final session = snapshot.data!;
                    final isLoggedIn = session['isLoggedIn'] ?? false;
                    final username = session['username'] ?? '';
                    
                    return Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                        ),
                        SizedBox(height: 20),
                        Text(
                          isLoggedIn 
                            ? 'Welcome back, $username!'
                            : 'Loading...',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: _responsiveValue(
                              context,
                              mobile: 12,
                              tablet: 14,
                              desktop: 16,
                            ),
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    );
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}