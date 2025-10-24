import 'package:flutter/material.dart';
import 'package:vision_erp_app/screens/app/intro_page_1.dart';
import 'package:vision_erp_app/screens/app/home_page.dart';
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
    await Future.delayed(const Duration(seconds: 5)); // Reduced from 10 to 3 seconds
    
    if (mounted) {
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
  }

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
              
              // Tagline - Responsive font size and padding with dark blue color
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
              
              // Loading indicator with intro status message
              FutureBuilder<bool>(
                future: SharedPreferencesService.isIntroShown(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    bool introShown = snapshot.data!;
                    return Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                        ),
                        SizedBox(height: 20),
                        Text(
                          introShown 
                            ? 'Welcome back!'
                            : 'First time setup...',
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